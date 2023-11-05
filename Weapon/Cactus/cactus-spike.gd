class_name CactusSpike extends Node2D

@export var damage_per_second := 100.0

func _process(delta):
	var parent = get_parent()
	if parent is Enemy:
		parent.take_damage(damage_per_second * delta)

