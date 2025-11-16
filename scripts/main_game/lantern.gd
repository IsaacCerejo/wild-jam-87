class_name Lantern
extends Area2D

var _dragging: bool = false
var _drag_offset: Vector2 = Vector2.ZERO

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Start dragging
				_dragging = true
				_drag_offset = global_position - event.position
			else:
				# Stop dragging
				_dragging = false

func _process(_delta: float) -> void:
	if _dragging:
		global_position = get_global_mouse_position() + _drag_offset
