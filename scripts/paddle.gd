extends CharacterBody2D
class_name Paddle

@export var player_side : Enums.PlayerSide

@onready var mesh_instance_2d : MeshInstance2D = %MeshInstance2D

var initial_x_position : float
var min_y_position : float
var max_y_position : float
var dimensions : Vector2

func _ready():
	var mesh : QuadMesh = mesh_instance_2d.mesh
	dimensions = mesh.size
	var half_paddle_height = dimensions.y / 2
	var half_paddle_width = dimensions.x / 2
	
	min_y_position = half_paddle_height
	max_y_position = get_viewport_rect().size.y - half_paddle_height
	
	match player_side:
		Enums.PlayerSide.LEFT:
			initial_x_position = half_paddle_width
		Enums.PlayerSide.RIGHT:
			initial_x_position = get_viewport_rect().size.x - half_paddle_width
	
	position.x = initial_x_position
	position.y = get_viewport_rect().size.y/2

func _physics_process(delta):
	move_and_slide()
	_fix_position_errors()

func _fix_position_errors() -> void:
	if initial_x_position != position.x:
		position = Vector2(initial_x_position, position.y)

func get_dimensions() -> Vector2:
	return dimensions
