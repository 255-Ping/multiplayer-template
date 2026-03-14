extends Node2D

func _on_host_button_pressed() -> void:
	SceneLoader.load_scene("res://scenes/overworld.tscn")
	ServerDataManagement.is_host = true

func _on_join_button_pressed() -> void:
	SceneLoader.load_scene("res://scenes/overworld.tscn")
	ServerDataManagement.is_host = false
