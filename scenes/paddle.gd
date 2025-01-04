extends CharacterBody2D

@export var speed = 200

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	_handle_input()
	move_and_slide()

func _handle_input() -> void:
	if Input.is_action_pressed("up"):
		velocity.y = -speed
	if Input.is_action_pressed("down"):
		velocity.y = speed
