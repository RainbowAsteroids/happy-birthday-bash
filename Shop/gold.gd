class_name Gold extends RigidBody2D

signal collected

@export var move_force := 50.

func _on_mouse_entered():
	collected.emit()
	queue_free()

func _physics_process(_delta):
	var to_mouse_hat = (MousePos.mouse_pos - global_position).normalized()
	apply_central_force(to_mouse_hat * move_force)

