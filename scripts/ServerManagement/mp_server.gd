extends Node

var peer : ENetMultiplayerPeer

var is_host: bool

var players = []

#NODES
@onready var player_scene = preload("res://scenes/player.tscn")

func host(port := 7777):
	print("Attempting to create server on port: ", port)
	ServerDataManagement.server_ip = "localhost"
	ServerDataManagement.server_port = port
	peer = ENetMultiplayerPeer.new()

	var err = peer.create_server(port)
	if err != OK:
		push_error("Issue creating server: ", err)
		return
	print("Server create: ", err)
	is_host = true
	multiplayer.multiplayer_peer = peer

	multiplayer.peer_connected.connect(_player_joined)
	multiplayer.peer_disconnected.connect(_player_left)
	
	print("Server started")
	
	var host_id = multiplayer.get_unique_id()
	players.append(host_id)

	spawn_player_rpc.rpc(host_id)

func join(ip, port := 7777):
	if is_host:
		print("Host cannot join servers")
		return
	print("Attempting to connect to: ", ip,":",port)
	ServerDataManagement.server_ip = ip
	ServerDataManagement.server_port = port
	peer = ENetMultiplayerPeer.new()

	var err = peer.create_client(ip, port)
	if err != OK:
		push_error("Issue connecting to server: ", err)
		return
	print("Client create: ", err)

	multiplayer.multiplayer_peer = peer

	multiplayer.connected_to_server.connect(_connected)
	multiplayer.connection_failed.connect(_failed)
	
func spawn_player(id):
	var player = player_scene.instantiate()

	player.name = str(id)

	player.set_multiplayer_authority(id)

	get_tree().current_scene.get_node("Players").add_child(player)

func _connected():
	print("Connected to server")

func _failed():
	print("Connection failed")

func _player_joined(id):
	print("Peer Connected: ", id)

	players.append(id)

	# spawn new player for everyone
	spawn_player_rpc.rpc(id)

	# tell the new client about existing players
	for p in players:
		if p != id:
			spawn_player_rpc.rpc_id(id, p)

func _player_left(id):
	print("Peer Left: ", id)
	
@rpc("any_peer","call_local")
func spawn_player_rpc(id):
	spawn_player(id)
