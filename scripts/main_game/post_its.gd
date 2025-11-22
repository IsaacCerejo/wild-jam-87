extends Node2D

# Maximum number of mushrooms to pick before fully dissolving the post-it
@export var dissolve_threshold: int = 25

@onready var post_its := {
	"TallMushroom": %PincaPostIt,
	"JesterMushroom": %TesouraPostIt,
	"BalloonMushroom": %SprayPostIt,
	"FaceMushroom": %DrillPostIt,
	"SquishyMushroom": %HammerPostIt
}


func _ready() -> void:
	Global.mushroom_picked.connect(_on_mushroom_picked)

func _on_mushroom_picked(mushroom_type: String) -> void:
	if not post_its.has(mushroom_type):
		return

	# Get sprite associated with this mushroom type
	var sprite: Sprite2D = post_its[mushroom_type]

	# Make sure sprite has a shader material
	var mat := sprite.material as ShaderMaterial
	if mat == null:
		return

	# Compute dissolve value based on progress
	var count: int = Global.mushrooms_picked[mushroom_type]
	var target_value: float = clamp(float(count) / float(dissolve_threshold), 0.0, 1.0)

	# Tween the shader uniform
	var tween := create_tween()
	tween.tween_property(
		mat,
		"shader_parameter/dissolve_amount",
		target_value,
		0.4
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	# If fully dissolved, hide sprite at the end
	if target_value >= 1.0:
		tween.tween_callback(func(): sprite.visible = false)
