extends Area2D

@export var player_side : Enums.PlayerSide

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		GameSignals.goal_scored.emit(player_side)
