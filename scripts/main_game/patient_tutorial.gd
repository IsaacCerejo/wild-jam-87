extends Patient
class_name PatientTutorial

# Override
func generate_mushrooms() -> void:
	var _mushroom_areas_picked: Array[PhysicsBody2D] = mushroom_areas
	for mushroom_scene in MUSHROOM_SCENES:
		var new_mushroom: Mushroom = mushroom_scene.instantiate() as Mushroom
		new_mushroom.picked.connect(_on_mushroom_picked)
		new_mushroom.z_index = 1
		_mushrooms.append(new_mushroom)
		var affected_area = _mushroom_areas_picked.pick_random()
		_mushroom_areas_picked.erase(affected_area)
		affected_area.add_child(new_mushroom)
		new_mushroom.position = affected_area.to_local(random_point_in_area(affected_area))
