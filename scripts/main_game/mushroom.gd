extends Area2D
class_name Mushroom

@export var allowed_tool_types: Array[Tool.ToolType] = []

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if Global.player.get_active_tool() != null:
			if allowed_tool_types.has(Global.player.get_active_tool().type):
				queue_free()
