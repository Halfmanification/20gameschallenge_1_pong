extends CharacterBody2D

@export var speed : int = 200
@export var controller_scheme : Enums.ControllerScheme = Enums.ControllerScheme.KEYBOARD

var initial_x_position : float

func _ready():
	initial_x_position = position.x

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	_handle_input()
	move_and_slide()
	
	if initial_x_position != position.x:
		position = Vector2(initial_x_position, position.y)

func _handle_input() -> void:
	match controller_scheme:
		Enums.ControllerScheme.MOUSE:
			_handle_mouse_inputs()
		Enums.ControllerScheme.KEYBOARD:
			_handle_keyboard_and_gamepad_inputs()
		Enums.ControllerScheme.GAMEPAD:
			_handle_keyboard_and_gamepad_inputs()

func _handle_mouse_inputs() -> void:
	pass

func _handle_keyboard_and_gamepad_inputs() -> void:
	if Input.is_action_pressed("up"):
		velocity.y = -speed
	if Input.is_action_pressed("down"):
		velocity.y = speed
