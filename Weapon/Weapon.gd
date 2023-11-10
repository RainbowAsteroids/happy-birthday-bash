class_name Weapon extends RigidBody2D

## Representation of a weapon

signal broken

var particle_scene := preload("res://particles.tscn")

## If the weapon durability is below or equal to zero, the weapon is "dead"
var dead := false

## The percentage of health the weapon should have before it plays a different hit sound
@export var danger_ratio := 0

## If the weapon's health is below danger_ratio percents, 
## then the weapon is in "danger"
var danger := false

## The health of the weapon
@export var durability := 25:
	set(value):
		if value <= 0 and not dead:
			broken.emit()

			var particles := particle_scene.instantiate()
			particles.global_position = global_position
			get_parent().add_child(particles)

			dead = true
			queue_free()
		durability = value
		danger = (durability as float) / (initial_durability as float) < danger_ratio

@onready var initial_durability := durability

## How much damage the weapon does when it hits something
@export var damage := 15.0

@onready var on_screen_indicator := %VisibleOnScreenNotifier2D
func _screen_exited():
	await get_tree().create_timer(1.).timeout

	if not on_screen_indicator.is_on_screen():
		global_position = MousePos.mouse_pos
		linear_velocity = Vector2()

func _ready():
	continuous_cd = RigidBody2D.CCD_MODE_DISABLED

@onready var audio_player := %AudioStreamPlayer2D

## This fires when the weapon hits an enemy
func _on_enemy_hit(enemy: Enemy):
	if danger:
		pass
		#audio_player.pitch_scale = .5
	audio_player.play()

	enemy.take_damage(damage)
	durability -= 1

@onready var moveable_handler := %MoveableHandler
## Actives/Deactivates the moveable_handler of this weapon.
func set_moving(value: bool):
	moveable_handler.moving = value
