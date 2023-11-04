extends Weapon

@export var damage_mul := 10.0

@onready var weaponCollisionHandler = $WeaponCollisionHandler as WeaponCollisionHandler

func _on_enemy_hit(enemy: Enemy):
	if enemy.damage_multiplier != damage_mul:
		enemy.damage_multiplied = true
		enemy.damage_multiplier = damage_mul
		durability -= 1

func _ready():
	weaponCollisionHandler.enemy_hit.connect(_on_enemy_hit)
