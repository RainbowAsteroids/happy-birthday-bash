extends CPUParticles2D

const duration := 0.25
const chill_time := 0.5

func _ready():
	emitting = true;
	await get_tree().create_timer(duration).timeout
	emitting = false;
	await get_tree().create_timer(chill_time).timeout
	queue_free()
