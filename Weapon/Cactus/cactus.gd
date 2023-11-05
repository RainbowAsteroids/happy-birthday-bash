extends DamageWeapon

@export var cactus_spike_scene: PackedScene
@export var cactus_spike_damage_per_second := 100.
@export var cactus_spike_offset := 5

func randsf():
	return (randf() * 2) - 1

func _on_weapon_collision_handler_enemy_hit(enemy: Enemy):
	var spike: CactusSpike = cactus_spike_scene.instantiate()
	
	spike.damage_per_second = cactus_spike_damage_per_second
	spike.position = Vector2(randsf() * cactus_spike_offset, randsf() * cactus_spike_offset)

	enemy.add_child(spike)
