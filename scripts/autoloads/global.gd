extends Node

# Constants
const SCENE_UIDS = {
	"START_MENU": "uid://dolritqgtceml",
	"MAIN_GAME": "uid://fwifwdj0klmd",
	"MAIN_GAME_UI": "uid://byg7j72h7pac6",
	"LOSE_SCREEN": "uid://dfox7aapmjh2k",
	"MUSHROOM": "uid://cfxgo5ye53do0"
}

# Game Controller
var game_controller: GameController
var player: Player
var time_bar: TimeBar
var score: int = 0

# Settings
var music_step: int = 9
var sound_step: int = 9

# Why do this?
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

# TODO: Remove this I think
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Escape"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	if event.is_action_pressed("Restart"):
		await Global.game_controller.change_scene(SCENE_UIDS.MAIN_GAME_UI, SCENE_UIDS.MAIN_GAME, TransitionSettings.TRANSITION_TYPE.FADE_TO_FADE)
	
	if event.is_action_pressed("Fullscreen"):
		var mode := DisplayServer.window_get_mode()
	
		if mode == DisplayServer.WINDOW_MODE_FULLSCREEN or mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func add_time_to_score() -> void:
	if time_bar:
		time_bar.stop_timer()
		score += int(time_bar.get_time_left())
