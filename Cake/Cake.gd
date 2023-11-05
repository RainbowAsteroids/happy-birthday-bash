class_name Cake extends StaticBody2D

static var instance: Cake

@export var health := 100.0

@onready var area := $Area2D as Area2D

func _init():
	Cake.instance = self

func _physics_process(delta: float):
	for body in area.get_overlapping_bodies():
		if body is Enemy:
			health -= body.damage * delta
	
	if health <= 0:
		print("ded")
