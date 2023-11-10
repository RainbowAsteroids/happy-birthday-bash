extends Node2D

var mouse_pos: Vector2

func _process(_delta):
	mouse_pos = get_global_mouse_position()
