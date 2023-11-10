extends Weapon

@export var cactus_spike_scene: PackedScene
@export var cactus_spike_damage_per_second := 100.
@export var cactus_spike_offset := 5

## random signed float [-1.0, 1.0]
func randsf():
	return (randf() * 2) - 1

func _on_enemy_hit(enemy: Enemy):
	super(enemy)
	
	var spike: CactusSpike = cactus_spike_scene.instantiate()
	
	spike.damage_per_second = cactus_spike_damage_per_second
	spike.position = Vector2(randsf() * cactus_spike_offset, randsf() * cactus_spike_offset)

	enemy.add_child(spike)
