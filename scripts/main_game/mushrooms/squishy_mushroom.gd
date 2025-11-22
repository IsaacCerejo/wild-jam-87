extends Mushroom
class_name SquishyMushroom

# const TIMING_MINI_GAME_SCENE: PackedScene = preload(Global.SCENE_UIDS.TIMING_MINI_GAME)

# var _in_mini_game: bool = false

# func _on_action_performed(_event: InputEvent) -> bool:
# 	if not _in_mini_game:
# 		_in_mini_game = true
# 		var mini_game: TimingMiniGame = TIMING_MINI_GAME_SCENE.instantiate() as TimingMiniGame
# 		add_child(mini_game)
# 		var accuracy_modifier: float = await mini_game.complete
# 		score_value = int(score_value * accuracy_modifier)
# 		_in_mini_game = false
# 		return true
# 	return false
