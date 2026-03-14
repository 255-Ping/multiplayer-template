extends CharacterBody2D

@export var speed := 200

func _ready():
	print("Player authority: ", get_multiplayer_authority())
	print("My peer id: ", multiplayer.get_unique_id())

	if is_multiplayer_authority():
		$Camera2D.enabled = true
	else:
		$Camera2D.enabled = false

func _physics_process(_delta):

	if not is_multiplayer_authority():
		return

	var input_dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)

	velocity = input_dir.normalized() * speed
	move_and_slide()
