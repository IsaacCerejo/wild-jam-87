extends Node2D
class_name Player

@onready var hand_sprite: AnimatedSprite2D = %HandSprite

var _active_tool: Tool = null:
	set = set_active_tool,
	get = get_active_tool

func _ready() -> void:
	Global.player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _exit_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(_delta: float) -> void:
	hand_sprite.global_position = get_global_mouse_position()

func set_active_tool(tool: Tool) -> void:
	_active_tool = tool
	assert(hand_sprite.sprite_frames.has_animation(_active_tool.name.to_lower()))
	hand_sprite.play(_active_tool.name.to_lower())

func get_active_tool() -> Tool:
	return _active_tool
