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

const OUTLINE_MATERIAL: ShaderMaterial = preload(Global.MATERIAL_UIDS.OUTLINE_MATERIAL)

@export var type: ToolType

@onready var sprite_2d: Sprite2D = %Sprite2D

var _original_material: Material = null

func _ready() -> void:
	_original_material = sprite_2d.material

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		picked_up.emit(self)

func _on_mouse_entered() -> void:
	sprite_2d.material = OUTLINE_MATERIAL

func _on_mouse_exited() -> void:
	sprite_2d.material = _original_material
