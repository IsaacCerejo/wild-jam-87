extends Node2D

@onready var mouth_sprite: Sprite2D = $"../MushroomAreas/Head/mouth"
@onready var eyes_sprite: Sprite2D = $"../MushroomAreas/Head/eyes"
@onready var hair_sprite: Sprite2D = $"../MushroomAreas/Head/hair"
@onready var torso_sprite: Sprite2D = $"../MushroomAreas/Torso/torso_skin"
@onready var left_arm_sprite: Sprite2D = $"../MushroomAreas/LeftArm/arm_skin"
@onready var right_arm_sprite: Sprite2D = $"../MushroomAreas/RightArm/arm_skin"
@onready var left_leg_sprite: Sprite2D = $"../MushroomAreas/LeftLeg/leg_skin"
@onready var right_leg_sprite: Sprite2D = $"../MushroomAreas/RightLeg/leg_skin"

const hair_colors: Array = [
	Color("8c4e34ff"),
	Color("2e4a37ff"),
	Color("2a3659ff"),
	Color("572b44ff"),
	Color("1d2b23ff"),
	Color("#5A5360"),
	Color("#5E4A45"),
	Color("635049ff"),
	Color("#4D5966"),
	Color("#445248"),
	Color("#453E4A"),
	Color("#3A424D"),
	Color("#2F3B32"),
	Color("#463B36"),
	Color("#3E3A38")
]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Restart"):
		_ready()

func _ready() -> void:
	mouth_sprite.texture = load_random_texture("res://assets/patient/mouth")
	hair_sprite.texture = load_random_texture("res://assets/patient/hair")
	eyes_sprite.texture = load_random_texture("res://assets/patient/eyes")
	torso_sprite.texture = load_random_texture("res://assets/patient/torso")
	left_arm_sprite.texture = load_random_texture("res://assets/patient/arm")
	right_arm_sprite.texture = load_random_texture("res://assets/patient/arm")
	left_leg_sprite.texture = load_random_texture("res://assets/patient/leg")
	right_leg_sprite.texture = load_random_texture("res://assets/patient/leg")
	randomize_hair_color()
	randomize_flip_torso()

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

func randomize_hair_color():
	hair_sprite.self_modulate = hair_colors[randi_range(0, hair_colors.size()-1)]

func randomize_flip_torso():
	torso_sprite.flip_v = randi_range(0,1)
