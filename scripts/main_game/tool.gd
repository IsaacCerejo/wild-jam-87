extends Area2D
class_name Tool

signal picked_up(tool: Tool)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		picked_up.emit(self)