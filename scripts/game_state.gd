extends Node

@export var win_score : int = 3

const GAME = preload("res://scenes/game.tscn")

var _player_data := {
	Enums.PlayerSide.LEFT: {
		"score": 0,
		"name": "Left"
	},
	Enums.PlayerSide.RIGHT: {
		"score": 0,
		"name": "Right"
	}
}

var _winner : Enums.PlayerSide

func _ready():
	GameSignals.new_game_started.connect(_on_new_game_started)
	GameSignals.goal_scored.connect(_on_goal_scored)

func _on_goal_scored(goal_side: Enums.PlayerSide) -> void:
	var scoring_player_side := _get_opponent_side(goal_side)
	var scoring_player = _player_data[scoring_player_side]
	
	scoring_player.score += 1
	GameSignals.score_updated.emit(scoring_player_side, scoring_player.score)
	
	if scoring_player.score >= win_score:
		GameSignals.game_won.emit()
		_winner = scoring_player_side

func _get_key(player_side: Enums.PlayerSide) -> String:
	return Enums.PlayerSide.keys()[player_side]

func _get_opponent_side(player_side: Enums.PlayerSide) -> Enums.PlayerSide:
	if player_side == Enums.PlayerSide.LEFT:
		return Enums.PlayerSide.RIGHT
	return Enums.PlayerSide.LEFT

func get_winner():
	return _player_data[_winner]

func _on_new_game_started():
	for key in _player_data:
		_player_data[key].score = 0
	get_tree().change_scene_to_packed(GAME)
