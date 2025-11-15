extends Control

@onready var options_menu: Control = %OptionsMenu
@onready var how_to_play_menu: Control = %HowToPlayMenu

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		_open_close_pause()

# Private functions
func _open_close_pause():
	visible = !visible
	if visible:
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	else:
		get_tree().paused = false
		options_menu.hide()
		how_to_play_menu.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

# Signal callbacks
func _on_resume_button_pressed() -> void:
	AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BUTTON_CLICK)
	_open_close_pause()

func _on_options_button_pressed() -> void:
	AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BUTTON_CLICK)
	options_menu.show()
	
func _on_how_to_play_button_pressed() -> void:
	AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BUTTON_CLICK)
	how_to_play_menu.show()

func _on_main_menu_button_pressed() -> void:
	AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BUTTON_CLICK)
	get_tree().paused = false
	Global.restart()
