extends CharacterBody2D

@export var speed : int = 200
@export var controller_scheme : Enums.ControllerScheme = Enums.ControllerScheme.MOUSE
@export var vertical_edge_distance : float

@onready var mesh_instance_2d : MeshInstance2D = %MeshInstance2D

var initial_x_position : float
var min_y_position : float
var max_y_position : float

func _ready():
	initial_x_position = position.x
	
	var mesh : QuadMesh = mesh_instance_2d.mesh
	var half_paddle_height = mesh.size.y / 2
	min_y_position = half_paddle_height + vertical_edge_distance
	max_y_position = get_viewport_rect().size.y - half_paddle_height - vertical_edge_distance

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	_handle_input()
	move_and_slide()
	
	# Fix the times when the ball pushes on the paddles a bit
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
	var mouse_position := get_viewport().get_mouse_position()
	position = Vector2(position.x, clamp(mouse_position.y, min_y_position, max_y_position))

func _handle_keyboard_and_gamepad_inputs() -> void:
	if Input.is_action_pressed("up"):
		velocity.y = -speed
	if Input.is_action_pressed("down"):
		velocity.y = speed
