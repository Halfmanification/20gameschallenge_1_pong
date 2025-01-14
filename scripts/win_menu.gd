extends CanvasLayer

@onready var label = %Label
@onready var play_again_button = %PlayAgainButton
@onready var quit_button = %QuitButton
@onready var win_sound = %WinSound

func _ready():
	play_again_button.pressed.connect(_on_play_again_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	var winner = GameState.get_winner()
	label.text = "Player " + str(winner.name) + " won the game!"
	
	win_sound.play()

func _on_play_again_button_pressed():
	GameSignals.new_game_started.emit()

func _on_quit_button_pressed():
	GameSignals.open_main_menu.emit()
