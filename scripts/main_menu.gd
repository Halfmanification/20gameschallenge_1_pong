extends CanvasLayer

@onready var start_button = %StartButton
@onready var quit_button = %QuitButton

const PLAYER_SELECT_MENU = preload("res://scenes/player_select_menu.tscn")

func _ready():
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

func _on_start_button_pressed():
	get_tree().change_scene_to_packed(PLAYER_SELECT_MENU)

func _on_quit_button_pressed():
	get_tree().call_deferred("quit")
