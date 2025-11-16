extends Node2D

func _ready() -> void:
	for child in get_children():
		if child is Tool:
			child.picked_up.connect(_on_tool_picked_up)
		else:
			push_error("Child of ToolSelector is not a Tool: %s" % child)

# Signal callbacks
func _on_tool_picked_up(tool: Tool):
	tool.hide()
	Global.player._active_tool = tool
	for child in get_children():
		if child is Tool and child != tool:
			child.show()
