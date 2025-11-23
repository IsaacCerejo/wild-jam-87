extends Control

@onready var mushroom_score_label: RichTextLabel = %MushroomScore
@onready var timer_score_label: RichTextLabel = %TimerScore
@onready var total_score_label: RichTextLabel = %TotalScore
@onready var new_best_label: RichTextLabel = %NewBest
@onready var high_score_label: RichTextLabel = %HighScore

func _ready() -> void:
	Global.high_score = max(Global.high_score, Global.compute_total_score())
	Global.save_game()

	mushroom_score_label.clear()
	mushroom_score_label.text = "%d" % Global.mushroom_score

	timer_score_label.clear()
	timer_score_label.text = "%d" % Global.time_score

	total_score_label.clear()
	total_score_label.text = "%d" % Global.compute_total_score()

	high_score_label.clear()
	high_score_label.text = "HIGHSCORE: %d" % Global.high_score

	if Global.compute_total_score() >= Global.high_score:
		new_best_label.visible = true
	else:
		new_best_label.visible = false

# Signal callbacks
func _on_main_menu_button_pressed() -> void:
	await Global.game_controller.change_scene(Global.SCENE_UIDS.START_MENU, "", TransitionSettings.TRANSITION_TYPE.FADE_TO_FADE)
