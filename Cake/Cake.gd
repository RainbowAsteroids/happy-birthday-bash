class_name Cake extends StaticBody2D

static var instance: Cake

@export var health := 100.0

@export var happy_sprite: Sprite2D
@export var scared_sprite: Sprite2D

var being_attacked := false

@onready var area := $Area2D as Area2D

func _init():
	Cake.instance = self

func _physics_process(delta: float):
	being_attacked = false

	for body in area.get_overlapping_bodies():
		if body is Enemy:
			being_attacked = true
			health -= body.damage * delta
	
	happy_sprite.visible = not being_attacked
	scared_sprite.visible = being_attacked

	if health <= 0:
		print("ded")
