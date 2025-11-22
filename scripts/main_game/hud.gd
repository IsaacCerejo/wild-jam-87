extends MarginContainer
class_name Hud

@onready var time_bar: TimeBar = %TimeBar
@onready var score_label: Label = %ScoreLabel

func start() -> void:
	update_score()
	visible = true
	time_bar.start_timer()

func update_score() -> void:
	score_label.text = str(Global.compute_total_score())