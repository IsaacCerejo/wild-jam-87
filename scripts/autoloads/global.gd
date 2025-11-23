extends Node

# Constants
const SCENE_UIDS = {
	"GAME_CONTROLLER": "uid://cyangrc80ocx0",
	"START_MENU": "uid://dolritqgtceml",
	"MAIN_GAME": "uid://fwifwdj0klmd",
	"MAIN_GAME_UI": "uid://byg7j72h7pac6",
	"LOSE_SCREEN": "uid://dfox7aapmjh2k",
	"PATIENT": "uid://mtilpmnd7m7y",
	"PATIENT_TUTORIAL": "uid://cypx2cfe52eck",
	"TALL_MUSHROOM": "uid://darqsw3l4uvnv",
	"STONE_MUSHROOM": "uid://bqgj0pn787y68",
	"BALLOON_MUSHROOM": "uid://i0birjinl1cf",
	"BUBONIC_MUSHROOM": "uid://8wqjjiw2tak3",
	"SQUISHY_MUSHROOM": "uid://c6mosdrb4vnvb",
	"TIMING_MINI_GAME": "uid://qe1rt7g386g7"
}

const MATERIAL_UIDS = {
	"OUTLINE_MATERIAL": "uid://bj6x4cma75nay",
	"FLASH_MATERIAL": "uid://c4id7ag22mv0v"
}

const SAVE_LOCATION: String = "user://save_game.json"
const ENCRYPTION_PASSWORD: String = "WildJam87"

@warning_ignore("UNUSED_SIGNAL")
signal round_changed(new_round: int)
@warning_ignore("UNUSED_SIGNAL")
signal mushroom_picked(mushroom_type: String)

# Game Controller
var game_controller: GameController
# Mal practical but for jam purposes. Ideally use signals.
var player: Player
var camera: Camera2D
var game_ui: MainGameUI
var time_score: int = 0
# Bad hardcoded mushroom types, but jam time constraints
var mushrooms_picked: Dictionary = {
	"TallMushroom": 0,
	"JesterMushroom": 0,
	"BalloonMushroom": 0,
	"FaceMushroom": 0,
	"SquishyMushroom": 0
}
var mushroom_score: int = 0
var high_score: int = 0

# Settings
var music_step: int = 9
var sound_step: int = 9

# Why do this?
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	load_game()

# TODO: Remove this I think
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Escape"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	if event.is_action_pressed("Fullscreen"):
		var mode := DisplayServer.window_get_mode()
	
		if mode == DisplayServer.WINDOW_MODE_FULLSCREEN or mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func add_mushroom_score(value: int) -> void:
	if game_ui and Global.game_ui.hud.visible:
		mushroom_score += value
		game_ui.hud.update_score()

func add_time_to_score() -> void:
	if game_ui and Global.game_ui.hud.visible:
		game_ui.hud.time_bar.stop_timer()
		time_score += int(game_ui.hud.time_bar.get_time_left())
		game_ui.hud.update_score()

func compute_total_score() -> int:
	return time_score + mushroom_score

func reset_score() -> void:
	time_score = 0
	mushroom_score = 0

func reset_mushrooms_picked() -> void:
	for key in mushrooms_picked.keys():
		mushrooms_picked[key] = 0

func save_game() -> void:
	var file := FileAccess.open_encrypted_with_pass(SAVE_LOCATION, FileAccess.WRITE, ENCRYPTION_PASSWORD)
	if file:
		file.store_var({
			"high_score": high_score
		})
		file.close()

func load_game() -> void:
	if FileAccess.file_exists(SAVE_LOCATION):
		var file := FileAccess.open_encrypted_with_pass(SAVE_LOCATION, FileAccess.READ, ENCRYPTION_PASSWORD)
		if file:
			var data = file.get_var()
			high_score = data.get("high_score", 0)
			file.close()
