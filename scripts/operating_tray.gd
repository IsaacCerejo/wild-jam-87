extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass	

func spawn():

	animation_player.play("Slide in")
	# lógica de gerar um paciente and such

func cured():
	animation_player.play("Slide out")
	# handle and cleanup
	queue_free() # mayhaps
