extends Area2D
class_name Mushroom

# Signal emitted when the mushroom is picked with the correct tool
signal picked(_mushroom: Mushroom)

@export var allowed_tool_types: Array[Tool.ToolType] = []

@export_group("Correct Animation")
@export var flash_intensity: float = 4.0
@export var flash_in_duration: float = 0.05
@export var flash_out_duration: float = 0.05
@export var flash_count: int = 1
@export var squash_scale: Vector2 = Vector2(1.3, 0.7)
@export var squash_duration: float = 0.12
@export var rotation_max_degrees: float = 6.0
@export var return_duration: float = 0.12

@export_group("Wrong Animation")
@export var wrong_flash_color: Color = Color(1, 0, 0, 1)
@export var wrong_flash_in_duration: float = 0.1
@export var wrong_flash_out_duration: float = 0.15
@export var wrong_flash_count: int = 1

@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var hit_particles: GPUParticles2D = %GPUParticles2D

var _busy: bool = false

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if _busy:
		return

	if event is InputEventMouseButton and event.pressed:
		if Global.player.get_active_tool() != null:
			if allowed_tool_types.has(Global.player.get_active_tool().type):
				_correct_animation()
				picked.emit(self)
				queue_free()
			else:
				await _wrong_animation()

func _correct_animation() -> void:
	_busy = true

	if hit_particles:
		hit_particles.restart()

	var tween: Tween = create_tween()

	# Flashing
	for i in flash_count:
		# Flash in
		tween.tween_property(
			sprite_2d,
			"modulate",
			Color(1, 1, 1, 1) * flash_intensity,
			flash_in_duration
		)

		# Squash and rotate
		if i == 0:
			tween.parallel().tween_property(
				sprite_2d,
				"scale",
				squash_scale,
				squash_duration
			)
			tween.parallel().tween_property(
				sprite_2d,
				"rotation_degrees",
				randf_range(-rotation_max_degrees, rotation_max_degrees),
				squash_duration
			)

		# Flash out
		tween.tween_property(
			sprite_2d,
			"modulate",
			Color(1, 1, 1, 1),
			flash_out_duration
		)

	# Return to normal
	tween.tween_property(
		sprite_2d,
		"scale",
		Vector2.ONE,
		return_duration
	)
	tween.tween_property(
		sprite_2d,
		"rotation_degrees",
		0.0,
		return_duration
	)

	await tween.finished

func _wrong_animation() -> void:
	_busy = true

	# Camera Shake
	if Global.camera != null:
		Global.camera.screen_shake()

	var tween: Tween = create_tween()

	# Flashing
	for i in wrong_flash_count:
		tween.tween_property(
			sprite_2d,
			"modulate",
			wrong_flash_color,
			wrong_flash_in_duration
		)
		tween.tween_property(
			sprite_2d,
			"modulate",
			Color(1, 1, 1, 1),
			wrong_flash_out_duration
		)

	await tween.finished
	_busy = false
