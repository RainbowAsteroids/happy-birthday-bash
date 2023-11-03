@tool
extends RigidBody2D

@export var radius := 15

func _draw():
	draw_circle(Vector2(), radius, Color.WHITE)
