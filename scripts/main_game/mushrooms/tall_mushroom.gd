extends Mushroom
class_name TallMushroom

@export var drag_distance_threshold: float = 50.0

@export_group("Drag Animation")
@export var initial_duration: float = 0.1
@export var initial_scale: Vector2 = Vector2(0.9, 0.9)
@export var target_scale: Vector2 = Vector2(1.2, 1.2)

var _dragging: bool = false
var _start_pos: Vector2

signal drag_finished(success: bool)

func _on_action_performed(event: InputEvent) -> bool:
	if not _dragging and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_dragging = true
		_start_pos = to_local(event.position)
		var _original_scale: Vector2 = sprite_2d.scale

		# Initial shrink animation
		var tween: Tween = create_tween()
		tween.tween_property(
			sprite_2d,
			"scale",
			initial_scale,
			initial_duration
		)

		var success: bool = await drag_finished
		_dragging = false

		# Scale back to normal
		var back_tween: Tween = create_tween()
		back_tween.tween_property(sprite_2d, "scale", _original_scale, return_duration)

		return success
	return false

func _input(event: InputEvent) -> void:
	if not _dragging:
		return

	if event is InputEventMouseMotion:
		var mouse_pos = get_local_mouse_position()
		var distance: float = (mouse_pos - _start_pos).length()
		var progress: float = clamp(distance / drag_distance_threshold, 0.0, 1.0)

		# Dragging animation
		var _target_scale: Vector2 = initial_scale.lerp(target_scale, progress)
		sprite_2d.scale = _target_scale

		if distance >= drag_distance_threshold:
			_dragging = false
			drag_finished.emit(true)

	elif event is InputEventMouseButton and not event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_dragging = false
		drag_finished.emit(false)
