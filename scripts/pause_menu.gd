extends CanvasLayer
class_name PauseMenu

@onready var resume_button = %ResumeButton
@onready var quit_button = %QuitButton

func _ready():
	resume_button.pressed.connect(_on_resume_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

func _input(event: InputEvent): 
	if event.is_action_pressed("menu_button"):
		_close()

func _on_resume_button_pressed():
	_close()

func _on_quit_button_pressed():
	GameSignals.open_main_menu.emit()
	_close()

func _close():
	GameSignals.close_pause_menu.emit(self)
