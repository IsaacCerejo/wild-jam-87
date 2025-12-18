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
@export_range(0, 20) var min_radius: float = 50.0
@export_range(10, 200) var max_attempts: int = 100

var _mushrooms: Array[Mushroom] = []
@onready var mushroom_areas: Array[Area2D] = [$MushroomAreas/Torso/TorsoArea, $MushroomAreas/Head/HeadArea, $MushroomAreas/LeftArm/LeftArmArea, $MushroomAreas/RightArm/RightArmArea, $MushroomAreas/LeftLeg/LeftLegArea, $MushroomAreas/RightLeg/RightLegArea]
var used_base_points: Array[int] = []

func _ready() -> void:
	pass


func generate_mushrooms() -> void:
	# Spawn mushrooms
	var spawned: int = 0
	var attempts: int = 0
	var points: Array[Vector2] = []
	while spawned < mushroom_count and attempts < max_attempts:
		attempts += 1

		var affected_area: Area2D = mushroom_areas.pick_random()
		var p: Vector2 = random_point_in_area(affected_area)

		if is_valid(p, points):
			points.append(p)
			
			# Mushroom selection
			var random_scene = MUSHROOM_SCENES.pick_random()
			var new_mushroom: Mushroom = random_scene.instantiate() as Mushroom
			new_mushroom.picked.connect(_on_mushroom_picked)
			new_mushroom.z_index = 1
			_mushrooms.append(new_mushroom)

			# Mushroom placement
			affected_area.add_child(new_mushroom)
			new_mushroom.position = affected_area.to_local(p)
		
			spawned += 1


func _on_mushroom_picked(mushroom: Mushroom) -> void:
	_mushrooms.erase(mushroom)
	if _mushrooms.size() == 0:
		cured.emit()

func random_point_in_area(area: Area2D) -> Vector2:
	var collision := area.get_child(0)
	assert(collision is CollisionShape2D)

	var shape: Shape2D = collision.shape
	assert(shape != null)

	if shape is RectangleShape2D:
		shape = shape as RectangleShape2D
		var ext: Vector2 = shape.size * 0.5
		return area.global_transform * Vector2(
			randf_range(-ext.x, ext.x),
			randf_range(-ext.y, ext.y)
		)

	if shape is CircleShape2D:
		var r: float = shape.radius * sqrt(randf())
		var a: float = randf() * TAU
		return area.global_transform * Vector2(
			cos(a) * r,
			sin(a) * r
		)

	return area.global_position

func is_valid(pos: Vector2, points: Array) -> bool:
	for p in points:
		if pos.distance_squared_to(p) < min_radius * min_radius:
			return false
	return true
