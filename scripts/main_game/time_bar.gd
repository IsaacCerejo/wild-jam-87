extends ProgressBar
class_name TimeBar

@export var time_limit: float = 60.0:
	set = set_time_limit

# Time it takes to reset the bar visually
@export var reset_duration: float = 0.5

@export_group("Warning Animation")
@export var warning_rotate_amount: float = 2.5 # degrees
@export var warning_rotate_duration: float = 0.05 # seconds per tween step
@export var warning_scale_up: Vector2 = Vector2(1.02, 0.98)
@export var warning_scale_duration: float = 0.05

var _time_left: float = 0.0:
	set = set_time_left,
	get = get_time_left

var _finished: bool = false
var _warn_played: bool = false

func _ready() -> void:
	Global.time_bar = self
	start_timer()

func _exit_tree() -> void:
	Global.time_bar = null

func _process(delta: float) -> void:
	if _finished:
		return
	
	if _time_left > 0:
		_time_left -= delta
		value = time_limit - _time_left
		# Play warning animation at half time
		if not _warn_played and _time_left <= time_limit * 0.5:
			_warn_played = true
			_play_warning_animation()
	else:
		_on_time_bar_finished()

# Public functions
func get_time_left() -> float:
	return _time_left

func set_time_left(new_time_left: float) -> void:
	_time_left = clamp(new_time_left, 0.0, time_limit)
	value = time_limit - _time_left

func add_time(amount: float) -> void:
	_time_left = clamp(_time_left + amount, 0.0, time_limit)
	value = time_limit - _time_left

func set_time_limit(new_time_limit: float) -> void:
	time_limit = new_time_limit
	max_value = time_limit
	_time_left = max_value
	value = 0
	_finished = false

func stop_timer() -> void:
	_finished = true

func reset_timer_animated() -> void:
	_finished = true
	var tween: Tween = create_tween()
	tween.tween_property(self, "value", 0, reset_duration)
	await tween.finished
	_time_left = 0
	value = 0

func start_timer() -> void:
	_finished = false
	_warn_played = false
	_time_left = time_limit
	max_value = time_limit
	value = 0

# Private functions
func _play_warning_animation() -> void:
	pivot_offset = size / 2 # center pivot for shake/scale

	var tween := create_tween()

	# Rotation shake
	tween.parallel().tween_property(self, "rotation_degrees", -warning_rotate_amount, warning_rotate_duration)
	tween.parallel().tween_property(self, "scale", warning_scale_up, warning_scale_duration)

	# Continue rotation back
	tween.tween_property(self, "rotation_degrees", warning_rotate_amount, warning_rotate_duration)
	tween.tween_property(self, "rotation_degrees", 0.0, warning_rotate_duration)
	tween.tween_property(self, "scale", Vector2.ONE, warning_scale_duration)

	tween.play()

# Signal callbacks
func _on_time_bar_finished() -> void:
	if _finished:
		return
	_finished = true
	await Global.game_controller.change_scene(Global.SCENE_UIDS.LOSE_SCREEN, "", TransitionSettings.TRANSITION_TYPE.FADE_TO_FADE)
