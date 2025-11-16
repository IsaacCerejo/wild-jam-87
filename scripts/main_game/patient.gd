extends Node2D
class_name Patient

# Signal for when the patient is cured
signal cured()

const MUSHROOM_SCENE: PackedScene = preload(Global.SCENE_UIDS.MUSHROOM)

@export var mushroom_count: int = 0

var _mushrooms: Array[Mushroom] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# spawn body with random skin
	generate_mushrooms()
		
	pass # Replace with function body.

func generate_mushrooms() -> void:
	# spawn mushrooms
	for i in range(mushroom_count):
		var new_mushroom: Mushroom = MUSHROOM_SCENE.instantiate() as Mushroom
		# TODO: set Mushrooms properties like allowed_tool_types and position properly
		new_mushroom.allowed_tool_types = [Tool.ToolType.PINCA]
		new_mushroom.picked.connect(_on_mushroom_picked)
		_mushrooms.append(new_mushroom)
		add_child(new_mushroom)
		# new_mushroom.set_global_position() posição válida


func _on_mushroom_picked(mushroom: Mushroom) -> void:
	_mushrooms.erase(mushroom)
	if _mushrooms.size() == 0:
		cured.emit()
