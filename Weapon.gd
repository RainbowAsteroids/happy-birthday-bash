class_name Weapon extends RigidBody2D

signal broken

@export var durability := 25:
	set(value):
		if value <= 0:
			broken.emit()
			queue_free()
		durability = value
