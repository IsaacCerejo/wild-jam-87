extends Node2D
class_name Patient

# Signal for when the patient is cured
signal cured()

const MUSHROOM_SCENE: PackedScene = preload(Global.SCENE_UIDS.MUSHROOM)

@export_range(0,27) var mushroom_count: int # Max is 27 due to only spawning 1 shroom per point, with 27 points. Check find_mushroom_position() 
@export_range(0,20) var shroom_deviation: float = 16.5

var _mushrooms: Array[Mushroom] = []
var mushroom_areas: Array[Node] = []
var unused_base_points: Array[Vector2] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var root_mushroom_areas = self.find_child("MushroomAreas")
	mushroom_areas = root_mushroom_areas.get_children()
	
	for area in mushroom_areas:
		for point in area.get_point_count():
			unused_base_points.append(area.to_global(area.get_point_position(point)))
	#TODO: spawn body with random skin

func generate_mushrooms() -> void:
	# spawn mushrooms
	
	# Pick 1 allowed tool only (assuming 1 type of mushroom per person)
	var tool_keys = Tool.ToolType.keys()
	
	for i in range(mushroom_count):
		var random_key = tool_keys.pick_random()
		var random_tool: Tool.ToolType = Tool.ToolType[random_key]
		var new_mushroom: Mushroom = MUSHROOM_SCENE.instantiate() as Mushroom
		new_mushroom.allowed_tool_types = [random_tool]
		#new_mushroom.set_rotation_degrees(randi_range(0,360))
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
	
	# Always use different base points
	var random_idx = randi_range(0,unused_base_points.size()-1)
	var affected_area = unused_base_points[random_idx]
	unused_base_points.pop_at(random_idx)

	new_mushroom_position = Vector2(affected_area.x + randf_range(-shroom_deviation,shroom_deviation) ,affected_area.y + randf_range(-shroom_deviation,shroom_deviation) )

	return new_mushroom_position
