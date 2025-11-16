extends Node2D

@export var mushroom_count := 0
var mushroom_scene = preload("res://scenes/main_game/mushroom.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# spawn body with random skin
	# spawn mushrooms
	for i in range(mushroom_count):
		var new_mushroom := mushroom_scene.instantiate()
		#new_mushroom.set_global_position() posição válida
		
	pass # Replace with function body.

func cured():
	# wait for table animation to end
	
	queue_free()
	pass
