class_name MoveableHandler extends Node2D

@export var k := 10.0

var moving := false
	#set (value):
		#parent.continuous_cd = \
			#RigidBody2D.CCD_MODE_CAST_SHAPE if value \
			#else RigidBody2D.CCD_MODE_DISABLED
		#moving = value

@onready var parent := get_parent() as RigidBody2D

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			moving = false

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton:
		if event.pressed:
			moving = true

func _ready():
	parent.continuous_cd = RigidBody2D.CCD_MODE_CAST_SHAPE
	parent.input_pickable = true
	parent.input_event.connect(_on_input_event)
	
func _physics_process(_delta):
	if moving:
		var to_mouse := get_global_mouse_position() - parent.global_position
		var x := to_mouse.length()
		var to_mouse_hat := to_mouse.normalized()

		var d := to_mouse_hat.dot(parent.linear_velocity.normalized())
		var mul := (-(d - 1) + 1) * 5
		

		parent.apply_central_force(to_mouse_hat * x * k * mul)
