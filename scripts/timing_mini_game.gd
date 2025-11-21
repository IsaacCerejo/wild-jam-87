extends Node2D
class_name TimingMiniGame

@onready var area_2d: Area2D = %Area2D

signal complete(accuracy_modifier: float)

var _perfect_scale: Vector2 = Vector2.ONE

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(area_2d, "scale", Vector2(0, 0), 3)

	await tween.finished

	complete.emit(0.0)
	queue_free()

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and not event.pressed:
		var current_scale: Vector2 = area_2d.scale
		var distance: float = (current_scale - _perfect_scale).length()
		var max_distance: float = _perfect_scale.length()
		var accuracy_modifier: float = clamp(1.0 - (distance / max_distance), 0.0, 1.0)
		
		complete.emit(accuracy_modifier)
		queue_free()

func _on_area_2d_mouse_exited() -> void:
	complete.emit(0.0)
	queue_free()
