class_name Gold extends RigidBody2D

signal collected

@export var move_force := 50.
@export var max_velocity := 75.

func _on_mouse_entered():
	collected.emit()
	queue_free()

func _physics_process(_delta):
	var to_mouse_hat = (get_global_mouse_position() - global_position).normalized()
	apply_central_force(to_mouse_hat * move_force)

	linear_velocity = linear_velocity.limit_length(max_velocity)
