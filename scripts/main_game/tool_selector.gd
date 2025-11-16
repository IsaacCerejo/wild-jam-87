extends Node2D

@export var hand_sprite: AnimatedSprite2D

var _active_tool: Tool = null

func _ready() -> void:
	for child in get_children():
		if child is Tool:
			child.picked_up.connect(_on_tool_picked_up)
		else:
			push_error("Child of ToolSelector is not a Tool: %s" % child)

# Signal callbacks
func _on_tool_picked_up(tool: Tool):
	tool.hide()
	_active_tool = tool
	assert(hand_sprite.sprite_frames.has_animation(_active_tool.name.to_lower()))
	hand_sprite.play(_active_tool.name.to_lower())
	for child in get_children():
		if child is Tool and child != _active_tool:
			child.show()
