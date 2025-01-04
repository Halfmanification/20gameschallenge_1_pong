extends Node

@export var win_score : int = 3

var _player_data := {
	Enums.PlayerSide.LEFT: {
		"score": 0
	},
	Enums.PlayerSide.RIGHT: {
		"score": 0
	}
}

func _ready():
	GameSignals.goal_scored.connect(_on_goal_scored)

func _on_goal_scored(player_side: Enums.PlayerSide) -> void:
	var player = _player_data[player_side]
	
	player.score += 1
	if player.score >= win_score:
		print("Player ", _get_key(player_side), " won the game!")
		get_tree().call_deferred("quit")
	

func _get_key(player_side: Enums.PlayerSide) -> String:
	return Enums.PlayerSide.keys()[player_side]
