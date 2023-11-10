extends Node2D

@export var enemy_scene: PackedScene

@export var minimum_respawn_time := 0.2
var respawn_chance := 1.0
@export var respawn_time := 1.:
	set(value):
		respawn_time = max(minimum_respawn_time, value)
		#respawn_chance += respawn_time - value # 0 if value >= minimum, positive if not

@export var enemy_parent: Node

func _on_timer_timeout():
	respawn_time -= randf() * 0.15

	# respawn_chance can be higher than 1. if so, generate multiple enemies
	# 2.35 = 100% chance + 100% chance + 35% chance
	var n := respawn_chance
	while randf() < n:
		n -= 1.0
		var enemy = enemy_scene.instantiate()
		enemy.global_position = global_position
	
		enemy_parent.add_child(enemy)

var clock := 0.0
func _process(delta):
	clock += delta

	if clock > respawn_time:
		_on_timer_timeout()
		clock = 0

func _ready():
	if enemy_parent == null:
		enemy_parent = self
