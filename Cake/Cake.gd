class_name Cake extends StaticBody2D

static var instance: Cake

@export var health := 100.0

func _init():
	Cake.instance = self
