extends Control

@onready var how_to_play_menu: Control = %HowToPlayMenu
@onready var options_menu: Control = %OptionsMenu

var _starting: bool = false

@export var patient_scene: PackedScene
@onready var current_patient: Node2D = $Patient
@onready var inicial_pos: Vector2 = current_patient.global_position
var can_press_patient: bool = true


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Global.reset_score()
	Global.reset_mushrooms_picked()
	if AudioManager.get_active_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC) == null:
		AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC)
	else:
		var music_audio: AudioStreamPlayer = AudioManager.get_active_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC)
		if is_instance_valid(music_audio):
			music_audio.get_stream_playback().switch_to_clip(0)


func _on_start_button_pressed() -> void:
	if _starting:
		return
	_starting = true
	cycle_patient()
	
	AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BUTTON_CLICK)
	await Global.game_controller.change_scene(Global.SCENE_UIDS.MAIN_GAME_UI, Global.SCENE_UIDS.MAIN_GAME, TransitionSettings.TRANSITION_TYPE.FADE_TO_FADE)

func _on_options_button_pressed() -> void:
	cycle_patient()
	AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.BUTTON_CLICK)
	options_menu.show()

func _on_how_to_play_button_pressed() -> void:
	cycle_patient()
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


	
func cycle_patient():
	if not can_press_patient:
		return
	
	can_press_patient = false
	
	var old_patient = current_patient

	var new_patient = patient_scene.instantiate()
	new_patient.position = Vector2(inicial_pos.x, -300)
	new_patient.rotation_degrees = randi_range(0,360)
	add_child(new_patient)

	current_patient = new_patient

	var tween := create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(old_patient,"position:y",1100,0.8)

	tween.parallel().tween_property(new_patient,"position:y",inicial_pos.y,0.8)

	await tween.finished
	old_patient.queue_free()
	can_press_patient = true
