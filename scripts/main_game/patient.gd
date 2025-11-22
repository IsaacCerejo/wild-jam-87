extends Node2D
class_name Patient

# Signal for when the patient is cured
signal cured()

const MUSHROOM_SCENES: Array[PackedScene] = [
	preload(Global.SCENE_UIDS.TALL_MUSHROOM),
	preload(Global.SCENE_UIDS.STONE_MUSHROOM),
	preload(Global.SCENE_UIDS.BALLOON_MUSHROOM),
	preload(Global.SCENE_UIDS.BUBONIC_MUSHROOM),
	preload(Global.SCENE_UIDS.SQUISHY_MUSHROOM),
]

@export_range(0, 27) var mushroom_count: int # Max is 27 due to only spawning 1 shroom per point, with 27 points. Check find_mushroom_position()
@export_range(0, 20) var shroom_deviation: float = 16.5

var _mushrooms: Array[Mushroom] = []
@onready var mushroom_areas: Array[Line2D] = [$MushroomAreas/Torso/TorsoArea, $MushroomAreas/Head/HeadArea, $MushroomAreas/LeftArm/LeftArmArea, $MushroomAreas/RightArm/RightArmArea, $MushroomAreas/LeftLeg/LeftLegArea, $MushroomAreas/RightLeg/RightLegArea]
var unused_base_points: Array[Vector2] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#TODO: spawn body with random skin

func generate_mushrooms() -> void:
	# Spawn mushrooms
	for i in range(mushroom_count):
		var random_scene = MUSHROOM_SCENES.pick_random()
		var new_mushroom: Mushroom = random_scene.instantiate() as Mushroom
		new_mushroom.picked.connect(_on_mushroom_picked)
		new_mushroom.z_index = 1
		_mushrooms.append(new_mushroom)
		var affected_area = mushroom_areas[randi_range(0, len(mushroom_areas) - 1)]
		affected_area.add_child(new_mushroom)
		new_mushroom.set_position(find_mushroom_position(affected_area))

func _on_mushroom_picked(mushroom: Mushroom) -> void:
	_mushrooms.erase(mushroom)
	if _mushrooms.size() == 0:
		cured.emit()

func find_mushroom_position(affected_area: Line2D) -> Vector2:
	var new_mushroom_position := Vector2()
	
	# Always use different base points
	var random_idx = randi_range(0, affected_area.get_point_count() - 1)
	var affected_point = affected_area.points[random_idx]
	#unused_base_points.pop_at(random_idx)

	new_mushroom_position = Vector2(affected_point.x + randf_range(-shroom_deviation, shroom_deviation), affected_point.y + randf_range(-shroom_deviation, shroom_deviation))

	return new_mushroom_position
