extends Control

@export var how_to_play: Control
@export var options_menu: Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("uid://fwifwdj0klmd")

func _on_options_pressed() -> void:
	options_menu.show()

func _on_how_to_play_pressed() -> void:
	how_to_play.show()

func _on_fullscreen_button_pressed() -> void:
	var mode := DisplayServer.window_get_mode()
	
	if mode == DisplayServer.WINDOW_MODE_FULLSCREEN or mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
