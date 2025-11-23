extends Control

@onready var mushroom_score_label: RichTextLabel = %MushroomScore
@onready var timer_score_label: RichTextLabel = %TimerScore
@onready var total_score_label: RichTextLabel = %TotalScore
@onready var high_score_label: RichTextLabel = %HighScore

func _ready() -> void:
	Global.high_score = max(Global.high_score, Global.compute_total_score())
	Global.save_game()

	mushroom_score_label.clear()
	mushroom_score_label.text = "[wave amp=50.0 freq=5.0 connected=1][rainbow freq=1.0 sat=0.8 val=0.8 speed=1.0]%d[/rainbow]" % Global.mushroom_score

	timer_score_label.clear()
	timer_score_label.text = "[wave amp=50.0 freq=5.0 connected=1][rainbow freq=1.0 sat=0.8 val=0.8 speed=1.0]%d[/rainbow]" % Global.time_score

	total_score_label.clear()
	total_score_label.text = "[wave amp=50.0 freq=5.0 connected=1][rainbow freq=1.0 sat=0.8 val=0.8 speed=1.0]%s[/rainbow]" % str("SCORE: " + str(Global.compute_total_score()))

	high_score_label.clear()
	high_score_label.text = "[wave amp=50.0 freq=5.0 connected=1][rainbow freq=1.0 sat=0.8 val=0.8 speed=1.0]HIGHSCORE: %d[/rainbow]" % Global.high_score

# Signal callbacks
func _on_main_menu_button_pressed() -> void:
	await Global.game_controller.change_scene(Global.SCENE_UIDS.START_MENU, "", TransitionSettings.TRANSITION_TYPE.FADE_TO_FADE)
