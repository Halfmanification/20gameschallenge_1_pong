extends CharacterBody2D

@export var speed : int = 400
@export var player_side : Enums.PlayerSide

@export_category("Player controls")
@export var controller_scheme : Enums.ControllerScheme = Enums.ControllerScheme.GAMEPAD

@export_subgroup("Keyboard settings")
@export var up : Key = KEY_W
@export var down : Key = KEY_S

@export_subgroup("Gamepad settings")
@export var device_id : int = 0

@onready var mesh_instance_2d : MeshInstance2D = %MeshInstance2D

var initial_x_position : float
var min_y_position : float
var max_y_position : float

func _ready():
	initial_x_position = position.x
	
	var mesh : QuadMesh = mesh_instance_2d.mesh
	var half_paddle_height = mesh.size.y / 2
	min_y_position = half_paddle_height
	max_y_position = get_viewport_rect().size.y - half_paddle_height

func _physics_process(delta):
	velocity = Vector2.ZERO
	_handle_input()
	move_and_slide()

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
	position = Vector2(position.x, clamp(mouse_position.y, min_y_position, max_y_position))

func _handle_gamepad_inputs() -> void:
	var y_axis_value = snapped(Input.get_joy_axis(device_id, JOY_AXIS_LEFT_Y), 0.2)
	if y_axis_value > 0 or y_axis_value < 0:
		velocity = Vector2(0, y_axis_value * speed)
	if Input.is_joy_button_pressed(device_id, JOY_BUTTON_DPAD_UP):
		velocity.y = -speed
	if Input.is_joy_button_pressed(device_id, JOY_BUTTON_DPAD_DOWN):
		velocity.y = speed

func _handle_keyboard_inputs() -> void:
	if Input.is_key_pressed(up):
		velocity.y = -speed
	if Input.is_key_pressed(down):
		velocity.y = speed

func _fix_position_errors() -> void:
	if initial_x_position != position.x:
		position = Vector2(initial_x_position, position.y)
