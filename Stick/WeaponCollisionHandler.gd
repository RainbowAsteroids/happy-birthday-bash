class_name WeaponCollisionHandler extends Node2D

signal enemy_hit(Enemy)

@onready var parent := get_parent() as RigidBody2D

func _on_body_entered(other: Node):
	if other is Enemy:
		enemy_hit.emit(other)

func _ready():
	parent.contact_monitor = true
	parent.max_contacts_reported = 10000 # arbitraily large
	parent.body_entered.connect(_on_body_entered)
