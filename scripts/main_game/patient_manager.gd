extends Node2D
class_name PatientManager

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var patient: Patient = %Patient

func _ready() -> void:
	patient.cured.connect(_on_patient_cured)
	_show_patient()

func _show_patient() -> void:
	patient.generate_mushrooms()

	animation_player.play("slide_in")
	# await animation_player.animation_finished

	Global.time_bar.start_timer()

func _on_patient_cured() -> void:
	# Add remaining time to score
	Global.add_time_to_score()

	# Animate timer reset
	Global.time_bar.reset_timer_animated()

	animation_player.play_backwards("slide_in")
	await animation_player.animation_finished

	_show_patient()
