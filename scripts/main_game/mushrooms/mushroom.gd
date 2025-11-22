extends Area2D
class_name Mushroom

# Signal emitted when the mushroom is picked with the correct tool
signal picked(_mushroom: Mushroom)

const OUTLINE_MATERIAL: ShaderMaterial = preload(Global.MATERIAL_UIDS.OUTLINE_MATERIAL)
const FLASH_MATERIAL: ShaderMaterial = preload(Global.MATERIAL_UIDS.FLASH_MATERIAL)

@export var allowed_tool_types: Array[Tool.ToolType] = []
@export var score_value: int = 10
@export var time_penalty: float = 5.0

@export_group("Correct Animation")
@export var flash_in_duration: float = 0.05
@export var flash_out_duration: float = 0.05
@export var flash_count: int = 1
@export var squash_scale: Vector2 = Vector2(1.3, 0.7)
@export var squash_duration: float = 0.12
@export var rotation_max_degrees: float = 6.0
@export var return_duration: float = 0.12

@export_group("Wrong Animation")
@export var wrong_flash_color: Color = Color(1, 0, 0, 1)
@export var wrong_flash_in_duration: float = 0.05
@export var wrong_flash_out_duration: float = 0.05
@export var wrong_flash_count: int = 1

@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var hit_particles: GPUParticles2D = %GPUParticles2D

var _busy: bool = false
var _original_material: Material = null

func _ready() -> void:
	_original_material = sprite_2d.material

func _physics_process(_delta: float) -> void:
	self.global_rotation = 0
	
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	assert(Global.player != null)
	var active_tool: Tool = Global.player.get_active_tool()

	if _busy or active_tool == null:
		return

	var is_tool_correct: bool = allowed_tool_types.has(active_tool.type)

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not is_tool_correct:
			if event.pressed:
				if Global.game_ui != null and Global.game_ui.hud.visible:
					Global.game_ui.hud.time_bar.add_time(-time_penalty)
				AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.WRONG_TOOL)
				get_viewport().set_input_as_handled()
				await _wrong_animation()
			return

		@warning_ignore("REDUNDANT_AWAIT")
		var result: bool = await _on_action_performed(event)

		if result:
			picked.emit(self)
			Global.mushroom_picked.emit(get_script().get_global_name())
			Global.mushrooms_picked[get_script().get_global_name()] += 1
			AudioManager.create_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.MUSHROOM_PICKED)
			Global.add_mushroom_score(score_value)
			get_viewport().set_input_as_handled()
			await _correct_animation()
			queue_free()

func _correct_animation() -> void:
	_busy = true

	if hit_particles:
		hit_particles.restart()

	var original_material: Material = sprite_2d.material
	var original_scale: Vector2 = sprite_2d.scale
	var original_rotation: float = sprite_2d.rotation_degrees

	var flash_material: ShaderMaterial = FLASH_MATERIAL.duplicate()
	sprite_2d.material = flash_material

	var tween: Tween = create_tween()

	for i: int in flash_count:
		tween.tween_property(
			flash_material,
			"shader_parameter/flash",
			true,
			flash_in_duration
		)
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
		tween.tween_property(
			flash_material,
			"shader_parameter/flash",
			false,
			flash_out_duration
		)
	tween.tween_property(
		sprite_2d,
		"scale",
		original_scale,
		return_duration
	)
	tween.tween_property(
		sprite_2d,
		"rotation_degrees",
		original_rotation,
		return_duration
	)

	await tween.finished
	sprite_2d.material = original_material
	_busy = false
	
func _wrong_animation() -> void:
	_busy = true

	if Global.camera != null:
		Global.camera.screen_shake()

	var original_material: Material = sprite_2d.material

	var flash_material: ShaderMaterial = FLASH_MATERIAL.duplicate()
	sprite_2d.material = flash_material
	flash_material.set_shader_parameter("flash_color", wrong_flash_color)

	var tween: Tween = create_tween()

	for i: int in wrong_flash_count:
		tween.tween_property(
			flash_material,
			"shader_parameter/flash",
			true,
			wrong_flash_in_duration
		)
		tween.tween_property(
			flash_material,
			"shader_parameter/flash",
			false,
			wrong_flash_out_duration
		)

	await tween.finished
	sprite_2d.material = original_material
	_busy = false

# Action performed check. Function meant to be overridden.
func _on_action_performed(event: InputEvent) -> bool:
	return (not event.pressed)

# Signal callbacks
func _on_mouse_entered() -> void:
	sprite_2d.material = OUTLINE_MATERIAL

func _on_mouse_exited() -> void:
	sprite_2d.material = _original_material
