extends Sprite2D

const limit := 12.0
const vel_limit := 24.0

@onready var last_position = global_position

var velocity := Vector2()

func randn() -> float:
	var result = randf() * 2
	return result - 1

func _process(_delta):
	var delta_pos = (global_position - last_position)

	#delta_pos += Vector2(randn() * delta_pos.length(), randn() * delta_pos.length())
	#position = delta_pos

	velocity += delta_pos
	position += velocity

	position = position.limit_length(limit)
	velocity = velocity.limit_length(vel_limit)

	last_position = global_position
