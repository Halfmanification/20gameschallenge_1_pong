extends Node2D

@onready var game_board = $GameBoard
@onready var paddle_left = %PaddleLeft
@onready var paddle_right = %PaddleRight
@onready var ball = %Ball

func _ready():
	var player_1 = Player.new()
	player_1.controller_scheme = Enums.ControllerScheme.KEYBOARD
	player_1.up = KEY_UP
	player_1.down = KEY_DOWN
	player_1.paddle = paddle_right
	add_child(player_1)
	player_1.name = "Player1"
	
	var player_2 : Node
	if GameState.player_mode == Enums.PlayerMode.PLAYERS_1:
		player_2 = AIOpponent.new()
		player_2.ball = ball
		player_2.name = "AIOpponent"
	elif GameState.player_mode == Enums.PlayerMode.PLAYERS_2:
		player_2 = Player.new()
		player_2.controller_scheme = Enums.ControllerScheme.KEYBOARD
		player_2.up = KEY_W
		player_2.down = KEY_S
		player_2.name = "Player2"
	
	player_2.paddle = paddle_left
	add_child(player_2)

func _input(event: InputEvent):
	if event.is_action_pressed("menu_button"):
		game_board.get_tree().paused = true
		GameSignals.open_pause_menu.emit()
