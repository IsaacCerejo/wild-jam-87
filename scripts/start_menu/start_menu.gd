extends Control

@onready var how_to_play_menu: Control = %HowToPlayMenu
@onready var options_menu: Control = %OptionsMenu

func _ready() -> void:
	if AudioManager.get_active_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC) == null:
		AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC)
	else:
		var music_audio: AudioStreamPlayer = AudioManager.get_active_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC)
		if is_instance_valid(music_audio):
			music_audio.get_stream_playback().switch_to_clip(0)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_start_button_pressed() -> void:
	AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BUTTON_CLICK)
	await Global.game_controller.change_scene(Global.SCENE_UIDS.MAIN_GAME_UI, Global.SCENE_UIDS.MAIN_GAME, TransitionSettings.TRANSITION_TYPE.FADE_TO_FADE)

func _on_options_button_pressed() -> void:
	AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BUTTON_CLICK)
	options_menu.show()

func _on_how_to_play_button_pressed() -> void:
	AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BUTTON_CLICK)
	how_to_play_menu.show()

func _on_fullscreen_button_pressed() -> void:
	AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BUTTON_CLICK)
	var mode := DisplayServer.window_get_mode()
	
	if mode == DisplayServer.WINDOW_MODE_FULLSCREEN or mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_quit_button_pressed() -> void:
	AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BUTTON_CLICK)
	get_tree().quit()
