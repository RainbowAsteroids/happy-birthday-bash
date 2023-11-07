extends Node2D

@export var enemy_scene: PackedScene

@export var minimum_respawn_time := 0.2
var respawn_chance := 1.0
@export var respawn_time := 1.:
	set(value):
		respawn_time = max(minimum_respawn_time, value)
		respawn_chance += respawn_time - value # 0 if value >= minimum, positive if not

		if timer != null:
			timer.start(respawn_time)

@export var enemy_parent: Node

@onready var timer = $SpawnTimer

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

func _ready():
	#print(respawn_time)
	timer.autostart = true
	timer.one_shot = true
	timer.start(respawn_time)

	if enemy_parent == null:
		enemy_parent = self
	
	timer.timeout.connect(_on_timer_timeout)
