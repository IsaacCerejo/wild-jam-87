extends Patient
class_name PatientTutorial

func _exit_tree() -> void:
	Global.reset_score()

# Override
func generate_mushrooms() -> void:
	for mushroom_scene in MUSHROOM_SCENES:
		var new_mushroom: Mushroom = mushroom_scene.instantiate() as Mushroom
		new_mushroom.picked.connect(_on_mushroom_picked)
		_mushrooms.append(new_mushroom)
		add_child(new_mushroom)
		new_mushroom.set_global_position(find_mushroom_position())