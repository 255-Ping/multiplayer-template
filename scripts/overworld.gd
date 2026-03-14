extends Node2D

func _ready() -> void:
	if SDM.is_host:
		Network.host()
	else:
		Network.join("localhost")
