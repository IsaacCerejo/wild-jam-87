extends Control

@onready var score_label: RichTextLabel = %ScoreLabel

func _ready() -> void:
	score_label.clear()
	score_label.text = "[wave amp=50.0 freq=5.0 connected=1][rainbow freq=1.0 sat=0.8 val=0.8 speed=1.0]%d[/rainbow]" % Global.score

# Signal callbacks
func _on_main_menu_button_pressed() -> void:
	await Global.game_controller.change_scene(Global.SCENE_UIDS.START_MENU, "", TransitionSettings.TRANSITION_TYPE.FADE_TO_FADE)
