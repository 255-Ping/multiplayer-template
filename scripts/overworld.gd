extends Node2D

func _ready() -> void:
	if ServerDataManagement.is_host:
		MpServer.host()
	else:
		MpServer.join("localhost")
