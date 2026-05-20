extends Node2D

@onready var mouth_sprite: Sprite2D = $"../BodyParts/Head/mouth"
@onready var eyes_sprite: Sprite2D = $"../BodyParts/Head/eyes"
@onready var hair_sprite: Sprite2D = $"../BodyParts/Head/hair"
@onready var torso_sprite: Sprite2D = $"../BodyParts/Torso/torso_skin"
@onready var left_arm_sprite: Sprite2D = $"../BodyParts/LeftArm/arm_skin"
@onready var right_arm_sprite: Sprite2D = $"../BodyParts/RightArm/arm_skin"
@onready var left_leg_sprite: Sprite2D = $"../BodyParts/LeftLeg/leg_skin"
@onready var right_leg_sprite: Sprite2D = $"../BodyParts/RightLeg/leg_skin"

@export var mouth_textures: Array[Texture2D]
@export var eye_textures: Array[Texture2D]
@export var hair_textures: Array[Texture2D]
@export var torso_textures: Array[Texture2D]
@export var arm_textures: Array[Texture2D]
@export var leg_textures: Array[Texture2D]

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
		randomize_character()

func _ready() -> void:
	randomize_character()

func randomize_character() -> void:
	mouth_sprite.texture = mouth_textures.pick_random()
	eyes_sprite.texture = eye_textures.pick_random()
	hair_sprite.texture = hair_textures.pick_random()
	torso_sprite.texture = torso_textures.pick_random()

	left_arm_sprite.texture = arm_textures.pick_random()
	right_arm_sprite.texture = arm_textures.pick_random()

	left_leg_sprite.texture = leg_textures.pick_random()
	right_leg_sprite.texture = leg_textures.pick_random()

	randomize_hair_color()
	randomize_flip_torso()

func randomize_hair_color():
	hair_sprite.self_modulate = hair_colors.pick_random()

func randomize_flip_torso():
	torso_sprite.flip_v = randi() % 2 == 0
