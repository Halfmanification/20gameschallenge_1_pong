extends AudioStreamPlayer

@export var normal_volume_db_offset := -10.0
@export var muted_volume_db_offset := -20.0

func _ready():
	GameSignals.open_pause_menu.connect(_on_open_pause_menu)
	GameSignals.close_pause_menu.connect(_on_close_pause_menu)
	volume_db = normal_volume_db_offset

func _on_open_pause_menu():
	_fade(muted_volume_db_offset, 1)

func _on_close_pause_menu(menu: PauseMenu):
	_fade(normal_volume_db_offset, 1)

func _fade(target_volume: float, duration: float) -> void:
	var tween := create_tween()
	tween.tween_property(self, "volume_db", target_volume, duration)
