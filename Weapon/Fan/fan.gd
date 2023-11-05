extends Weapon

@export var wind_force := 30.0
@export var velocity_divisor := 100.0

@onready var wind_hitbox := $WindHitbox as Area2D

func _physics_process(_delta):
	for body in wind_hitbox.get_overlapping_bodies():
		if body is Enemy:
			var r_hat = (body.global_position - global_position).normalized()

			var velocity_factor = linear_velocity.length() / velocity_divisor

			body.apply_central_force(r_hat * wind_force * velocity_factor)

func _on_weapon_collision_handler_enemy_hit(_enemy: Enemy):
	durability -= 1

