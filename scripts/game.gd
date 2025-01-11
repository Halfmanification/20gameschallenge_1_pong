extends Node2D

@onready var game_board = $GameBoard

func _input(event: InputEvent):
	if event.is_action_pressed("menu_button"):
		game_board.get_tree().paused = true
		GameSignals.open_pause_menu.emit()
