extends CharacterBody2D

@export var initial_speed : float = 400
@export var initial_angle : float = PI/4

func _ready():
	velocity = Vector2(cos(initial_angle), sin(initial_angle)) * initial_speed
	
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
	return true

func _handle_paddle_collision(collision: KinematicCollision2D) -> bool:
	if not collision.get_collider() is CharacterBody2D:
		return false
	
	if collision.get_normal().x == 0:
		return false
		
	velocity.x = -velocity.x
	return true
