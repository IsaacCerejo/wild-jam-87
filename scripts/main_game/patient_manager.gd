extends Node2D
class_name PatientManager

@onready var tray: Sprite2D = $Tray
@onready var animation_player: AnimationPlayer = %AnimationPlayer

var patient: Patient

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
	patient = PATIENT_SCENE.instantiate() as Patient
	tray.add_child(patient)
	patient.cured.connect(_on_patient_cured)
	#TODO scale mushrooms by round
	patient.mushroom_count = 12
	patient.generate_mushrooms()

	animation_player.play("slide_in")
	# TODO: Yes or nay?
	# await animation_player.animation_finished

	Global.time_bar.start_timer()

func _on_patient_cured() -> void:
	# Add remaining time to score
	Global.add_time_to_score()

	# Animate timer reset
	Global.time_bar.reset_timer_animated()

	animation_player.play_backwards("slide_in")
	await animation_player.animation_finished
	patient.queue_free()
	
	_new_patient()
