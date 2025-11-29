extends Node2D

@onready var mouth_sprite: Sprite2D = $"../MushroomAreas/Head/mouth"
@onready var eyes_sprite: Sprite2D = $"../MushroomAreas/Head/eyes"
@onready var hair_sprite: Sprite2D = $"../MushroomAreas/Head/hair"
@onready var torso_sprite: Sprite2D = $"../MushroomAreas/Torso/torso_skin"
@onready var left_arm_sprite: Sprite2D = $"../MushroomAreas/LeftArm/arm_skin"
@onready var right_arm_sprite: Sprite2D = $"../MushroomAreas/RightArm/arm_skin"
@onready var left_leg_sprite: Sprite2D = $"../MushroomAreas/LeftLeg/leg_skin"
@onready var right_leg_sprite: Sprite2D = $"../MushroomAreas/RightLeg/leg_skin"


func _ready() -> void:
	mouth_sprite.texture = load_random_texture("res://assets/patient/mouth")
	hair_sprite.texture = load_random_texture("res://assets/patient/hair")
	eyes_sprite.texture = load_random_texture("res://assets/patient/eyes")
	torso_sprite.texture = load_random_texture("res://assets/patient/torso")
	left_arm_sprite.texture = load_random_texture("res://assets/patient/arm")
	right_arm_sprite.texture = load_random_texture("res://assets/patient/arm")
	left_leg_sprite.texture = load_random_texture("res://assets/patient/leg")
	right_leg_sprite.texture = load_random_texture("res://assets/patient/leg")

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
