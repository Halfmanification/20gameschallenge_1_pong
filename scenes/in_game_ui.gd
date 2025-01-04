extends CanvasLayer

@onready var label_left = %LabelLeft
@onready var label_right = %LabelRight

# Called when the node enters the scene tree for the first time.
func _ready():
	GameSignals.score_updated.connect(_on_score_updated)
	label_left.text = "0"
	label_right.text = "0"

func _on_score_updated(player_side: Enums.PlayerSide, score: int) -> void:
	match player_side:
		Enums.PlayerSide.LEFT:
			label_left.text = str(score)
		Enums.PlayerSide.RIGHT:
			label_right.text = str(score)
