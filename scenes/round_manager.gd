extends Node2D

@export var TimeBar: ProgressBar
@onready var operating_tray: Node2D = $"../OperatingTray"

func _ready() -> void:
	start_round()


func start_round():
	var tween = get_tree().create_tween()
	tween.tween_property(TimeBar, "value", 100, 10)
	operating_tray.spawn()


func _on_time_bar_value_changed(value: float) -> void:
	if value <= 0:
		Global.restart()
