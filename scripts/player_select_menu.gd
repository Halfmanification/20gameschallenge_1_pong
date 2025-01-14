extends CanvasLayer

@onready var one_player_button = %OnePlayerButton
@onready var two_player_button = %TwoPlayerButton
@onready var back_button = %BackButton

const MAIN_MENU = preload("res://scenes/main_menu.tscn")

func _ready():
	one_player_button.pressed.connect(_on_one_player_button_pressed)
	two_player_button.pressed.connect(_on_two_player_button_pressed)
	back_button.pressed.connect(_on_back_button_pressed)

func _on_one_player_button_pressed():
	GameSignals.player_mode_selected.emit(Enums.PlayerMode.PLAYERS_1)

func _on_two_player_button_pressed():
	GameSignals.player_mode_selected.emit(Enums.PlayerMode.PLAYERS_2)

func _on_back_button_pressed():
	GameSignals.open_main_menu.emit()
