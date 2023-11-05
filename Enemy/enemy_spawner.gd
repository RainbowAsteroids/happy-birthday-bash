extends Node2D

@export var enemy_scene: PackedScene

@export var respawn_time := 1.:
	set(value):
		respawn_time = value
		if timer != null:
			timer.start(respawn_time)

@export var enemy_parent: Node

@onready var timer = $SpawnTimer

func _on_timer_timeout():
	print("timeout")
	respawn_time -= randf() * 0.05
	var enemy = enemy_scene.instantiate()
	enemy.global_position = global_position
	
	enemy_parent.add_child(enemy)

func _ready():
	print(respawn_time)
	timer.autostart = true
	timer.start(respawn_time)

	if enemy_parent == null:
		enemy_parent = self
	
	timer.timeout.connect(_on_timer_timeout)
