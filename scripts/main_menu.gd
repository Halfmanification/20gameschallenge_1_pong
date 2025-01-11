extends CanvasLayer

@onready var start_button = %StartButton
@onready var settings_button = %SettingsButton
@onready var quit_button = %QuitButton

const GAME = preload("res://scenes/game.tscn")

func _ready():
	start_button.pressed.connect(_on_start_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

func _on_start_button_pressed():
	get_tree().change_scene_to_packed(GAME)

func _on_settings_button_pressed():
	pass

func _on_quit_button_pressed():
	get_tree().call_deferred("quit")
