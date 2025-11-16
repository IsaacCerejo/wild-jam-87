extends Node2D
class_name ToolSelector

func _ready() -> void:
	assert(Global.player != null)
	Global.player.tool_dropped.connect(_on_player_tool_dropped)
	for child in get_children():
		if child is Tool:
			child.picked_up.connect(_on_tool_picked_up)
		else:
			push_error("Child of ToolSelector is not a Tool: %s" % child)

# Signal callbacks
func _on_player_tool_dropped() -> void:
	for child in get_children():
		if child is Tool:
			child.show()

func _on_tool_picked_up(picked_tool: Tool):
	picked_tool.hide()
	Global.player.set_active_tool(picked_tool)
	for child in get_children():
		if child is Tool and child != picked_tool:
			child.show()
