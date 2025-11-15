extends Node2D

@export var TimeBar: ProgressBar

func _ready() -> void:
	start_round()


func start_round():
	var tween = get_tree().create_tween()
	tween.tween_property(TimeBar, "value", 0, 10)


func _on_time_bar_value_changed(value: float) -> void:
	if value <= 0:
		Global.restart()
