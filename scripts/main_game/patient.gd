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
@onready var head: RigidBody2D = $Head
@onready var left_arm: RigidBody2D = $LeftArm
@onready var right_arm: RigidBody2D = $RightArm
@onready var left_leg: RigidBody2D = $LeftLeg
@onready var right_leg: RigidBody2D = $RightLeg
@onready var limb_list: Array[RigidBody2D] = [head, left_arm, right_arm, left_leg, right_leg]

@export_range(0, 27) var mushroom_count: int # Max is 27 due to only spawning 1 shroom per point, with 27 points. Check find_mushroom_position()
@export_range(0, 20) var shroom_deviation: float = 16.5

var _mushrooms: Array[Mushroom] = []
var mushroom_areas: Array[Node] = []
var unused_base_points: Array[Vector2] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# call me lebron james the way i hardcode this shit like a baller
	mushroom_areas = [$MushroomAreas/Head/HeadArea, $MushroomAreas/LeftArm/LeftArmArea, $MushroomAreas/RightArm/RightArmArea, $MushroomAreas/LeftLeg/LeftLegArea, $MushroomAreas/RightLeg/RightLegArea, $MushroomAreas/Torso/TorsoArea]
	
	for area in mushroom_areas:
		for point in area.get_point_count():
			unused_base_points.append(area.to_global(area.get_point_position(point)))
			
	#TODO: spawn body with random skin

func generate_mushrooms() -> void:
	# Spawn mushrooms
	for i in range(mushroom_count):
		var random_scene = MUSHROOM_SCENES.pick_random()
		var new_mushroom: Mushroom = random_scene.instantiate() as Mushroom
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
	var random_idx = randi_range(0, unused_base_points.size() - 1)
	var affected_area = unused_base_points[random_idx]
	unused_base_points.pop_at(random_idx)

	new_mushroom_position = Vector2(affected_area.x + randf_range(-shroom_deviation, shroom_deviation), affected_area.y + randf_range(-shroom_deviation, shroom_deviation))

	return new_mushroom_position
