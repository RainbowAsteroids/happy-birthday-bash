extends Sprite2D

const limit := 12.0
const vel_limit := 48.0

@onready var last_position = global_position

var velocity := Vector2()

func _process(_delta):
	var delta_pos = (global_position - last_position)
	velocity += delta_pos
	position += velocity

	position = position.limit_length(limit)
	velocity = velocity.limit_length(vel_limit)
