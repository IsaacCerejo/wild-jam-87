extends ProgressBar

var _time_left: float = 0.0

func _ready() -> void:
	_time_left = max_value
	value = _time_left

func _process(delta: float) -> void:
	if _time_left > 0:
		_time_left -= delta
		value = _time_left
	else:
		_on_time_bar_finished()

func _on_time_bar_finished() -> void:
	await Global.game_controller.change_scene(Global.SCENE_UIDS.START_MENU, "", TransitionSettings.TRANSITION_TYPE.FADE_TO_FADE)
