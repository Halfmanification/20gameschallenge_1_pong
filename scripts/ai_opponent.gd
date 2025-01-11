extends Node
class_name AIOpponent

@export var paddle : Paddle
@export var ball : Ball

@export var speed : float = 300
@export_range(0.0, 1.0) var precision : float

var performing_tween_move := false
var max_position_error : float

func _ready():
	max_position_error = paddle.get_dimensions().y * 2

func _physics_process(delta):
	if not performing_tween_move:
		_move()

func _move():
	var difference = abs(ball.position.y - paddle.position.y)
	if ball.position.y < paddle.position.y and difference > 10:
		paddle.velocity.y = -speed
	elif ball.position.y > paddle.position.y and difference > 10:
		paddle.velocity.y = speed
	else:
		var tween = create_tween()
		tween.finished.connect(_on_move_tween_finished)
		tween.tween_property(paddle, "velocity:y", 0, 0.1)
		performing_tween_move = true

func _on_move_tween_finished():
	performing_tween_move = false
