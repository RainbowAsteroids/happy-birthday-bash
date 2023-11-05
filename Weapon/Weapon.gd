class_name Weapon extends RigidBody2D

signal broken

@export var durability := 25:
	set(value):
		if value <= 0:
			broken.emit()
			queue_free()
		durability = value
		danger = (durability as float) / (initial_durability as float) < danger_ratio

@onready var initial_durability := durability
@onready var moveable_handler := $MoveableHandler as MoveableHandler
@onready var weapon_collision_handler := $WeaponCollisionHandler as WeaponCollisionHandler

var audio_player: AudioStreamPlayer
var danger := false

@export var danger_ratio := 0.4

func _ready():
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = preload("res://weapon_audio.tres")

	add_child(audio_player)

	weapon_collision_handler.enemy_hit.connect(_on_enemy_hit)

func _on_enemy_hit(_enemy: Enemy):
	#print("hai")
	if danger:
		audio_player.pitch_scale = .5
	audio_player.play()

func set_moving(value: bool):
	moveable_handler.moving = value
