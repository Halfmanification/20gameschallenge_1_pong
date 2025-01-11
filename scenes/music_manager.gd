extends AudioStreamPlayer

@export var normal_volume_db_offset := -10.0
@export var muted_volume_db_offset := -20.0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameSignals.open_pause_menu.connect(_on_open_pause_menu)
	GameSignals.close_pause_menu.connect(_on_close_pause_menu)
	volume_db = normal_volume_db_offset

func _on_open_pause_menu():
	volume_db = muted_volume_db_offset

func _on_close_pause_menu(menu: PauseMenu):
	print("hello")
	volume_db = normal_volume_db_offset
