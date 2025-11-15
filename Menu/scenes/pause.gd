extends Control

@export var options_menu: Control
@export var how_to_play_menu: Control

@export var resume_button: Button
@export var options_button: Button
@export var how_to_play_button: Button

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		open_close_pause()
		
func open_close_pause():
	
	visible = !visible
	if visible:
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	else:
		get_tree().paused = false
		options_menu.hide()
		how_to_play_menu.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_resume_button_pressed() -> void:
	open_close_pause()

func _on_options_button_pressed() -> void:
	options_menu.show()

func close_optins():
	options_menu.hide()
	
func _on_how_to_play_button_pressed() -> void:
	how_to_play_menu.show()

func close_how_to_play():
	how_to_play_menu.hide()

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	Global.restart()
