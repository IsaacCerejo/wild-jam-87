extends Patient
class_name PatientTutorial

func _exit_tree() -> void:
	Global.reset_score()

# Override
func generate_mushrooms() -> void:
	for mushroom_scene in MUSHROOM_SCENES:
		var new_mushroom: Mushroom = mushroom_scene.instantiate() as Mushroom
		new_mushroom.picked.connect(_on_mushroom_picked)
		new_mushroom.z_index = 1
		_mushrooms.append(new_mushroom)
		var affected_area = mushroom_areas[randi_range(0,len(mushroom_areas)-1)]
		affected_area.add_child(new_mushroom)
		new_mushroom.set_position(find_mushroom_position(affected_area))
