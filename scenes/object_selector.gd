extends Node2D

@export var hand_sprite: AnimatedSprite2D

var active_object: String = ""

func _ready() -> void:
	for button in get_children():
		button.connect("pressed", button_pressed.bind(button))
		

func button_pressed(pressed_button: Button):
	
	pressed_button.hide()
	active_object = pressed_button.name
	hand_sprite.play(active_object)
	
	for button in get_children():
		if button != pressed_button:
			button.show()
	
