extends Node

@onready var buttons = get_parent().find_children("*", "Button", true)
@export var click_sound: AudioStreamPlayer

func _ready() -> void:
	for button in buttons:
		button.button_down.connect(func(): click_sound.play())
