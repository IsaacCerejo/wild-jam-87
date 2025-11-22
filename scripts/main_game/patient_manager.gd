extends Node2D
class_name PatientManager

# For every round_frequency rounds, increase mushroom count by mushroom_increase
@export_range(1, 10) var round_frequency: int = 1
@export_range(1, 10) var mushroom_increase: int = 1

@onready var tray: Sprite2D = $Tray
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var patient: Patient
var current_round: int = 0
var total_mushroom_count: int = 0

const PATIENT_SCENE: PackedScene = preload(Global.SCENE_UIDS.PATIENT)
const PATIENT_TUTORIAL_SCENE: PackedScene = preload(Global.SCENE_UIDS.PATIENT_TUTORIAL)

func _ready() -> void:
	patient = PATIENT_TUTORIAL_SCENE.instantiate() as PatientTutorial
	tray.add_child(patient)
	patient.cured.connect(_on_patient_cured)
	patient.generate_mushrooms()

	animation_player.play("slide_in")
	# TODO: Yes or nay?
	# await animation_player.animation_finished


func _new_patient() -> void:
	current_round += 1
	Global.round_changed.emit(current_round)

	patient = PATIENT_SCENE.instantiate() as Patient
	tray.add_child(patient)
	patient.cured.connect(_on_patient_cured)
	
	var base_count = patient.MUSHROOM_SCENES.size()

	if current_round % round_frequency == 0:
		total_mushroom_count += mushroom_increase

	patient.mushroom_count = base_count + total_mushroom_count

	patient.generate_mushrooms()

	animation_player.play("slide_in")
	# TODO: Yes or nay?
	# await animation_player.animation_finished

	Global.game_ui.hud.start()

func _on_patient_cured() -> void:
	# Add remaining time to score
	Global.add_time_to_score()
	# Animate timer reset
	Global.game_ui.hud.time_bar.reset_timer()

	animation_player.play_backwards("slide_in")
	await animation_player.animation_finished
	patient.queue_free()
	
	_new_patient()
