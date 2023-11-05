@tool
extends Node2D

@export var length := 150: 
	set(value):
		length = value
		queue_redraw()

@export var background_color := Color.RED: 
	set(value):
		background_color = value
		queue_redraw()

@export var foreground_color := Color.GREEN: 
	set(value):
		foreground_color = value
		queue_redraw()

@export var width := 5.0:
	set(value):
		width = value
		queue_redraw()

@onready var cake := get_parent() as Cake
@onready var initial_health := cake.health

func _process(_delta):
	queue_redraw()

func _draw():
	var half_length := length / 2

	var green_length: float

	if cake.health <= 0:
		green_length = 0
	else:
		green_length = (cake.health / initial_health) * length

	draw_line(
		Vector2(-half_length, 0),
		Vector2(length - half_length, 0),
		background_color,
		width
	)

	draw_line(
		Vector2(-half_length, 0),
		Vector2(green_length - half_length, 0),
		foreground_color,
		width
	)
