extends RigidBody2D

@export var durability := 10 
@export var damage_mul := 10.0

@onready var weaponCollisionHandler = $WeaponCollisionHandler as WeaponCollisionHandler

func _on_enemy_hit(enemy: Enemy):
	if enemy.damage_multiplier != damage_mul:
		enemy.damage_multiplier = damage_mul
		durability -= 1
	
	if durability <= 0:
		queue_free()

func _ready():
	weaponCollisionHandler.enemy_hit.connect(_on_enemy_hit)
