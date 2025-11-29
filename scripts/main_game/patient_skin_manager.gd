extends Node2D

@onready var head_sprite: Sprite2D = $"../MushroomAreas/Head/Sprite2D"
@onready var torso_sprite: Sprite2D = $"../MushroomAreas/Torso/Sprite2D"
@onready var left_arm_sprite: Sprite2D = $"../MushroomAreas/LeftArm/Sprite2D"
@onready var right_arm_sprite: Sprite2D = $"../MushroomAreas/RightArm/Sprite2D"
@onready var left_leg_sprite: Sprite2D = $"../MushroomAreas/LeftLeg/Sprite2D"
@onready var right_leg_sprite: Sprite2D = $"../MushroomAreas/RightLeg/Sprite2D"
@onready var hair_sprite: Sprite2D = $"../MushroomAreas/Head/HairRoot/Hair"

func _ready() -> void:
	head_sprite.texture = load_random_texture("res://assets/patient/head/")
	torso_sprite.texture = load_random_texture("res://assets/patient/torso")
	left_arm_sprite.texture = load_random_texture("res://assets/patient/left_arm")
	right_arm_sprite.texture = load_random_texture("res://assets/patient/right_arm")
	left_leg_sprite.texture = load_random_texture("res://assets/patient/left_leg")
	right_leg_sprite.texture = load_random_texture("res://assets/patient/right_leg")
	hair_sprite.texture = load_random_texture("res://assets/patient/hair")

func load_random_texture(folder_path: String) -> Texture2D:
	
	var folder := DirAccess.open(folder_path)
	var assets_available: Array[String] = []
	
	folder.list_dir_begin()

	var asset_path := folder.get_next()
	while asset_path != "":
		if asset_path.get_extension() == "png":
			assets_available.append(asset_path)
		asset_path = folder.get_next()

	folder.list_dir_end()
	
	var chosen_asset = assets_available.pick_random()

	return load(folder_path + "/" + chosen_asset)
