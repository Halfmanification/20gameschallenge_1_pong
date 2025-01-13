extends Node

const MAIN_MENU = preload("res://scenes/main_menu.tscn")
const PAUSE_MENU = preload("res://scenes/pause_menu.tscn")
const WIN_MENU = preload("res://scenes/win_menu.tscn")

func _ready():
	GameSignals.open_main_menu.connect(_on_open_main_menu)
	GameSignals.open_pause_menu.connect(_on_open_pause_menu)
	GameSignals.close_pause_menu.connect(_on_close_pause_menu)
	GameSignals.game_won.connect(_on_game_won)

#region Main Menu
func _on_open_main_menu():
	if get_tree().paused:
		get_tree().paused = false
	
	get_tree().change_scene_to_packed(MAIN_MENU)
#endregion

#region Pause Menu
func _on_open_pause_menu():
	var pause_menu = PAUSE_MENU.instantiate()
	
	get_tree().current_scene.call_deferred("add_child", pause_menu)
	get_tree().paused = true

func _on_close_pause_menu(pause_menu: PauseMenu):
	get_tree().paused = false
	pause_menu.queue_free()
#endregion

#region Win Menu
func _on_game_won():
	get_tree().change_scene_to_packed(WIN_MENU)
#endregion
