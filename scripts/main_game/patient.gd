extends Node2D
class_name Patient

# Signal for when the patient is cured
signal cured()

const MUSHROOM_SCENE: PackedScene = preload(Global.SCENE_UIDS.MUSHROOM)

@export var mushroom_count: int = 0

var _mushrooms: Array[Mushroom] = []
var mushroom_areas: Array[Node] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root_mushroom_areas = self.find_child("MushroomAreas")
	mushroom_areas = root_mushroom_areas.get_children()
	# spawn body with random skin
		
	pass # Replace with function body.

func generate_mushrooms() -> void:
	# spawn mushrooms
	
	# Pick 1 allowed tool only (assuming 1 type of mushroom per person)
	var tool_keys = Tool.ToolType.keys()
	var random_key = tool_keys.pick_random()
	var random_tool: Tool.ToolType = Tool.ToolType[random_key]
	
	for i in range(mushroom_count):
		var new_mushroom: Mushroom = MUSHROOM_SCENE.instantiate() as Mushroom
		# TODO: set Mushroom sprite depending on allowed tool
		new_mushroom.allowed_tool_types = [random_tool]
		new_mushroom.picked.connect(_on_mushroom_picked)
		_mushrooms.append(new_mushroom)
		add_child(new_mushroom)
		new_mushroom.set_global_position(find_mushroom_position())

func _on_mushroom_picked(mushroom: Mushroom) -> void:
	_mushrooms.erase(mushroom)
	if _mushrooms.size() == 0:
		cured.emit()

func find_mushroom_position() -> Vector2:
	var new_mushroom_position := Vector2()
	var affected_area:Line2D = mushroom_areas[randi_range(0,len(mushroom_areas)-1)] # Get random area
	
	var base_point_idx = randi_range(0,affected_area.get_point_count()-1)
	var base_point_position: Vector2 = affected_area.get_point_position(base_point_idx)
	new_mushroom_position = affected_area.get_global_position() + Vector2(base_point_position.x,base_point_position.y)
	
	return new_mushroom_position
