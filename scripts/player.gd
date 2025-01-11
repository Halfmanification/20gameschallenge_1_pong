extends Node
class_name PLayer

@export var paddle : Paddle

@export var speed : float = 400
@export var player_side : Enums.PlayerSide

@export_category("Player controls")
@export var controller_scheme : Enums.ControllerScheme = Enums.ControllerScheme.GAMEPAD

@export_subgroup("Keyboard settings")
@export var up : Key = KEY_W
@export var down : Key = KEY_S

@export_subgroup("Gamepad settings")
@export var device_id : int = 0

func _physics_process(delta):
	paddle.velocity = Vector2.ZERO
	_handle_input()

func _handle_input() -> void:
	match controller_scheme:
		Enums.ControllerScheme.MOUSE:
			_handle_mouse_inputs()
		Enums.ControllerScheme.KEYBOARD:
			_handle_keyboard_inputs()
		Enums.ControllerScheme.GAMEPAD:
			_handle_gamepad_inputs()

func _handle_mouse_inputs() -> void:
	var mouse_position := get_viewport().get_mouse_position()
	paddle.position = Vector2(paddle.position.x, clamp(mouse_position.y, paddle.min_y_position, paddle.max_y_position))

func _handle_gamepad_inputs() -> void:
	var y_axis_value = snapped(Input.get_joy_axis(device_id, JOY_AXIS_LEFT_Y), 0.2)
	if y_axis_value > 0 or y_axis_value < 0:
		paddle.velocity = Vector2(0, y_axis_value * speed)
	if Input.is_joy_button_pressed(device_id, JOY_BUTTON_DPAD_UP):
		paddle.velocity.y = -speed
	if Input.is_joy_button_pressed(device_id, JOY_BUTTON_DPAD_DOWN):
		paddle.velocity.y = speed

func _handle_keyboard_inputs() -> void:
	if Input.is_key_pressed(up):
		paddle.velocity.y = -speed
	if Input.is_key_pressed(down):
		paddle.velocity.y = speed
