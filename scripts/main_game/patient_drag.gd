extends Node2D

@onready var mouse_pin: PinJoint2D = $MousePin
@onready var mouse_body: StaticBody2D = $MousePin/MouseBody

@onready var head: RigidBody2D = $"../BodyParts/Head"
@onready var left_arm: RigidBody2D = $"../BodyParts/LeftArm"
@onready var right_arm: RigidBody2D = $"../BodyParts/RightArm"
@onready var left_leg: RigidBody2D = $"../BodyParts/LeftLeg"
@onready var right_leg: RigidBody2D = $"../BodyParts/RightLeg"

var dragging = false

func _ready():
	head.input_event.connect(_on_input_event.bind(head))
	left_arm.input_event.connect(_on_input_event.bind(left_arm))
	right_arm.input_event.connect(_on_input_event.bind(right_arm))
	left_leg.input_event.connect(_on_input_event.bind(left_leg))
	right_leg.input_event.connect(_on_input_event.bind(right_leg))

func _physics_process(_delta: float) -> void:
	mouse_pin.global_position = get_global_mouse_position()
	
func _input(event):
	if dragging and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
			dragging = false
			mouse_pin.set_node_b("")

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int, sender:RigidBody2D):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if Global.player==null or Global.player.get_active_tool() == null :
		dragging = true
		mouse_pin.set_node_b(sender.get_path())
	
		@warning_ignore("REDUNDANT_AWAIT")
		var result: bool = await _let_go(event)
		if result:
			dragging = false
			mouse_pin.set_node_b("")
	pass
	
# Action performed check. Function meant to be overridden.
func _let_go(event: InputEvent) -> bool:
	return (not event.pressed)
