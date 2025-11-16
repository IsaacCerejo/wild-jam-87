extends Line2D

const MAX_POINTS: int = 50
const FOLLOW_STRENGTH: float = 0.2
const DOWNWARD_SPEED: float = 300
const BASE_POSITION: Vector2 = Vector2(640, 900)

var _points_array: Array[Vector2] = []

func _ready():
	_points_array.resize(MAX_POINTS)
	for i in range(MAX_POINTS):
		_points_array[i] = BASE_POSITION

func _process(delta: float):
	# The tip of the arm follows the mouse
	_points_array[0] = get_global_mouse_position()

	# Each point smoothly follows the previous one
	for i in range(1, MAX_POINTS):
		_points_array[i] = _points_array[i].lerp(_points_array[i - 1], FOLLOW_STRENGTH)

	# Base is fixed
	_points_array[MAX_POINTS - 1] = BASE_POSITION

	# Apply downward drift to all points except the base
	for i in range(MAX_POINTS - 1):
		_points_array[i].y += DOWNWARD_SPEED * delta

	# Update Line2D points
	points = _points_array
