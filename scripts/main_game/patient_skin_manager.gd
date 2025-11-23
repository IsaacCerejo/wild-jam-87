extends Node2D

@onready var torso_animation_player: AnimationPlayer = $"../MushroomAreas/Torso/TorsoAnimationPlayer"
@onready var head_animPlayer: AnimationPlayer = $"../MushroomAreas/Head/HeadAnimations"
@onready var left_arm_animation_player: AnimationPlayer = $"../MushroomAreas/LeftArm/LeftArmAnimationPlayer"
@onready var right_arm_animation_player: AnimationPlayer = $"../MushroomAreas/RightArm/RightArmAnimationPlayer"
@onready var left_leg_animation_player: AnimationPlayer = $"../MushroomAreas/LeftLeg/LeftLegAnimationPlayer"
@onready var hair_animation_player: AnimationPlayer = $"../MushroomAreas/Head/HairRoot/HairAnimations"

const head_sprites = ["Head","Head_2","Head_3","Head_4","Head_5","Head_6","Head_7"]
const torso_sprites = ["Torso","Torso_2","Torso_3","Torso_4","Torso_5"]
const right_arm_sprites = ["RightArm","RightArm_2","RightArm_3","RightArm_4","RightArm_5"]
const left_leg_sprites = ["LeftLeg","LeftLeg_2","LeftLeg_3","LeftLeg_4"]
const left_arm_sprites = ["LeftArm","LeftArm_2","LeftArm_3"]
const hair_sprites = ["Hair","Hair_2","Hair_3","Hair_4","Hair_5","Hair_6","Hair_7","Hair_8"]

func _ready() -> void:
	head_animPlayer.play(head_sprites.pick_random())
	torso_animation_player.play(torso_sprites.pick_random())
	right_arm_animation_player.play(right_arm_sprites.pick_random())
	left_leg_animation_player.play(left_leg_sprites.pick_random())
	left_arm_animation_player.play(left_arm_sprites.pick_random())
	hair_animation_player.play(hair_sprites.pick_random())
