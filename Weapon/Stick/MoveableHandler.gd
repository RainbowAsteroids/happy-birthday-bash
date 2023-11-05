class_name MoveableHandler extends Node2D

@export var k := 10.0
@export var yank := 5.0
@export var torque := 100

var moving := false

var torque_direction := 1

@onready var parent := get_parent() as RigidBody2D

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if not event.pressed:
			pass
			#moving = false

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton:
		if event.pressed:
			moving = true
			torque_direction = -1 if randf() > 0.5 else 1

func _draw():
	if moving:
		draw_line(
			Vector2(), 
			get_local_mouse_position(), 
			Color.WHITE, 
			1, 
			true
		)

func _process(_delta):
	queue_redraw()

func _ready():
	parent.input_pickable = true
	parent.input_event.connect(_on_input_event)
	
func _physics_process(_delta):
	if moving:
		var to_mouse := get_global_mouse_position() - parent.global_position
		var x := to_mouse.length()
		var to_mouse_hat := to_mouse.normalized()

		var d := to_mouse_hat.dot(parent.linear_velocity.normalized())
		var mul := (-(d - 1) + 1) * yank
		
		var force = to_mouse_hat * x * k * mul
		parent.apply_central_force(force)
		parent.apply_torque(torque * force.length() / 30 * torque_direction)
