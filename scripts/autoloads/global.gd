extends Node

var game_controller: GameController
var music_step: int = 9
var sound_step: int = 9

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Escape"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	if event.is_action_pressed("Restart"):
		replay()
	
	if event.is_action_pressed("Fullscreen"):
		var mode := DisplayServer.window_get_mode()
	
		if mode == DisplayServer.WINDOW_MODE_FULLSCREEN or mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func restart():
	get_tree().change_scene_to_file("uid://dolritqgtceml")
	
func replay():
	get_tree().change_scene_to_file("uid://fwifwdj0klmd")
