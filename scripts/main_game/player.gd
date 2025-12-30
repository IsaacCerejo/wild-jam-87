extends Node2D
class_name Player

signal tool_dropped()

@onready var hand_sprite: AnimatedSprite2D = %HandSprite

var _active_tool: Tool = null:
	set = set_active_tool,
	get = get_active_tool

func _ready() -> void:
	Global.player = self
	
	# This is because the mouse appears for 1 frame at the top corner
	await get_tree().create_timer(0.01).timeout 
	show()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if _active_tool != null:
			tool_dropped.emit()
			set_active_tool()

#func _exit_tree() -> void:
	#Global.player = null

func _physics_process(_delta: float) -> void:
	hand_sprite.global_position = get_global_mouse_position()

func set_active_tool(tool: Tool = null) -> void:
	_active_tool = tool
	if _active_tool != null:
		assert(hand_sprite.sprite_frames.has_animation(_active_tool.name.to_lower()))
		hand_sprite.play(_active_tool.name.to_lower())
	else:
		hand_sprite.play("empty")

func get_active_tool() -> Tool:
	return _active_tool
