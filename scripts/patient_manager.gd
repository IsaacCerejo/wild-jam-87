extends Node

@onready var operating_tray: OperatingTray = %OperatingTray

func _ready() -> void:
	start_round()

func start_round():
	# Start Timer...
	operating_tray.spawn()
