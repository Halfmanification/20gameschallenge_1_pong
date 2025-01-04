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
	GameSignals.game_won.connect(_on_game_won)

func _on_goal_scored(goal_side: Enums.PlayerSide) -> void:
	var scoring_player_side := _get_opponent_side(goal_side)
	var scoring_player = _player_data[scoring_player_side]
	
	scoring_player.score += 1
	GameSignals.score_updated.emit(scoring_player_side, scoring_player.score)
	
	if scoring_player.score >= win_score:
		get_tree().call_deferred("quit")

func _get_key(player_side: Enums.PlayerSide) -> String:
	return Enums.PlayerSide.keys()[player_side]

func _get_opponent_side(player_side: Enums.PlayerSide) -> Enums.PlayerSide:
	if player_side == Enums.PlayerSide.LEFT:
		return Enums.PlayerSide.RIGHT
	return Enums.PlayerSide.LEFT

func _check_win_condition() -> void:
	for player_side in _player_data.keys():
		var player = _player_data[player_side]
		if player.score >= win_score:
			GameSignals.game_won.emit(_get_key(player_side))

func _on_game_won(winning_player_side: Enums.PlayerSide) -> void:
	get_tree().call_deferred("quit")
