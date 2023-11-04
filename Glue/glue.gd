extends Weapon

@export var mass_mul = 10
@export var damp_mul = 5

func _on_weapon_collision_handler_enemy_hit(enemy: Enemy):
	if not enemy.slowed:
		enemy.slowed = true
		enemy.mass *= mass_mul
		enemy.linear_damp *= damp_mul
		enemy.linear_velocity = Vector2()

		durability -= 1

