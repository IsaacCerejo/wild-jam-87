extends Area2D
class_name Tool

enum ToolType {
	PINCA,
	SPRAY,
	TESOURA,
	DRILL,
	HAMMER
}

signal picked_up(tool: Tool)

@export var type: ToolType

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		picked_up.emit(self)
