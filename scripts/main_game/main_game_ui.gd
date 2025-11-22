extends Control
class_name MainGameUI

@onready var hud: Hud = %HUD
@onready var pause_menu: PauseMenu = %PauseMenu

func _ready() -> void:
	Global.game_ui = self

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		pause_menu._open_close_pause()

func _exit_tree() -> void:
	Global.game_ui = null
