class_name Weapon extends RigidBody2D

signal broken

var particle_scene := preload("res://particles.tscn")

var dead := false

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
@onready var moveable_handler := $MoveableHandler as MoveableHandler
@onready var weapon_collision_handler := $WeaponCollisionHandler as WeaponCollisionHandler

var audio_player: AudioStreamPlayer
var danger := false

@export var danger_ratio := 0

func _screen_exited(indicator: VisibleOnScreenNotifier2D):
	await get_tree().create_timer(1.).timeout

	if not indicator.is_on_screen():
		global_position = get_global_mouse_position()
		linear_velocity = Vector2()

func _ready():
	continuous_cd = RigidBody2D.CCD_MODE_DISABLED

	audio_player = AudioStreamPlayer.new()
	audio_player.stream = preload("res://weapon_audio.tres")

	add_child(audio_player)

	weapon_collision_handler.enemy_hit.connect(_on_enemy_hit)

	var indicator = VisibleOnScreenNotifier2D.new()

	indicator.screen_exited.connect(_screen_exited.bind(indicator))

	add_child(indicator)

func _on_enemy_hit(_enemy: Enemy):
	#print("hai")
	if danger:
		pass
		#audio_player.pitch_scale = .5
	audio_player.play()

func set_moving(value: bool):
	moveable_handler.moving = value
