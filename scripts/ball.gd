extends CharacterBody2D
class_name Ball

@export var initial_speed : float = 400
@export var initial_angle : float = PI/4

@onready var audio_stream_player : AudioStreamPlayer2D = %AudioStreamPlayer2D

var initial_position : Vector2
var _play_sound := false

func _ready():
	GameSignals.goal_scored.connect(_on_goal_scored)
	initial_position = position
	_reset_ball()

func _process(delta):
	if _play_sound:
		audio_stream_player.play()
		_play_sound = false

func _physics_process(delta) -> void:
	move_and_slide()
	_handle_collision()

func _handle_collision() -> void:
	var has_bounced_of_wall := false
	var has_bounced_of_paddle := false
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		if has_bounced_of_wall == false:
			has_bounced_of_wall = _handle_wall_collision(collision)
		
		if has_bounced_of_paddle == false:
			has_bounced_of_paddle = _handle_paddle_collision(collision)

func _handle_wall_collision(collision: KinematicCollision2D) -> bool:
	if not collision.get_collider() is StaticBody2D:
		return false
	
	if collision.get_normal().y == 0:
		return false
		
	velocity.y = -velocity.y
	audio_stream_player.volume_db = randf_range(0.7, 0.9) * velocity.normalized().length()
	audio_stream_player.pitch_scale = randf_range(0.85, 0.95)
	_play_sound = true
	return true

func _handle_paddle_collision(collision: KinematicCollision2D) -> bool:
	if not collision.get_collider() is CharacterBody2D:
		return false
	
	if collision.get_normal().x == 0:
		return false
	
	velocity.x = -velocity.x
	audio_stream_player.volume_db = randf_range(0.9, 1.4) * velocity.normalized().length()
	audio_stream_player.pitch_scale = randf_range(0.98, 1.02)
	_play_sound = true
	return true

func _on_goal_scored(player_side: Enums.PlayerSide) -> void:
	_reset_ball()

func _reset_ball() -> void:
	velocity = Vector2(cos(initial_angle), sin(initial_angle)) * initial_speed
	position = initial_position
