extends Node2D

@export var enemy_scene: PackedScene

@export var scale_factor := 0.05
@export var minimum_respawn_time := 0.2
@export var respawn_time := 1.:
	set(value):
		respawn_time = max(minimum_respawn_time, value)
		#respawn_chance += respawn_time - value # 0 if value >= minimum, positive if not

@export var enemy_parent: Node

func _on_timer_timeout():
	respawn_time -= randf() * scale_factor * respawn_time

	if World.instance.enemy_count < ProjectSettings.get_setting("global/max_enemy_count"):
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
