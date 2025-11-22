extends Control
class_name MainGameUI

@onready var hud: Control = %HUD
@onready var pause_menu: Control = %PauseMenu

func _ready() -> void:
	Global.game_ui = self

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		pause_menu._open_close_pause()

func _exit_tree() -> void:
	Global.game_ui = null