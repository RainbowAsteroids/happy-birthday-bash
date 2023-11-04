extends RigidBody2D

@export var damage := 15.0

@onready var weaponCollisionHandler = $WeaponCollisionHandler as WeaponCollisionHandler

func _on_enemy_hit(enemy: Enemy):
	enemy.take_damage(damage)

func _ready():
	weaponCollisionHandler.enemy_hit.connect(_on_enemy_hit)
