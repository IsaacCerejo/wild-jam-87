extends Node2D
class_name OperatingTray

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func spawn():
	animation_player.play("Slide in")
	# lógica de gerar um paciente and such

func cured():
	animation_player.play_backwards("Slide in")
	# handle and cleanup
	queue_free() # mayhaps
