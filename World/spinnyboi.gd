extends RigidBody2D

@export var rotation_speed := 360

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		apply_torque_impulse(rotation_speed)

