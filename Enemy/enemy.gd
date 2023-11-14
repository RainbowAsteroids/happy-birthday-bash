class_name Enemy extends RigidBody2D

signal wall_damaged
signal create_gold(amount: int, pos: Vector2)

@export var damage := 3.0
@export var health := 100.0

@export var max_speed := 50.0
@export var acceleration := 15.0
@export var torque := 5000.0

@export var flick := 2.0
@export var yank := 500.0

@export var sprite: Node2D

@export var head_pos: Node2D

@export var damage_modulate := Color.RED

@onready var cake := Cake.instance
@onready var initial_mass = mass

var dead = false

var damage_multiplier := 1.0

var slowed := false
var damage_multiplied := false

## Number of spikes on the enemy, at least 1 to guarentee one gold created on death
var spike_count = 1

func _physics_process(_delta):
	var goal := cake.global_position - global_position
	var goal_hat := goal.normalized()
	
	var angle := Vector2.RIGHT.rotated(rotation).angle_to(goal_hat)
	
	if sign(angle) != sign(angular_velocity):
		flick = 3.0

	# abs(angle) / PI will be 1 if the angle is maximally inaccurate and 0 if maximally accurate
	var angle_accuracy = (1 + abs(angle) / PI) * flick

	apply_torque(sign(angle) * torque * angle_accuracy)

	# always move in the direction we are rotated
	var f_hat = Vector2.RIGHT.rotated(rotation)
	apply_central_force(f_hat * acceleration * initial_mass)

#func create_gold():
	#var gold = gold_scene.instantiate()
	#gold.global_position = global_position
	#get_parent().add_child(gold)


func take_damage(amount: float):
	if not dead:
		health -= amount * damage_multiplier

		if health <= 0:
			dead = true
			
			var gold_count := 0

			for i in range(spike_count):
				gold_count += 1

			while randf() < 0.4:
				gold_count += 1

			create_gold.emit(gold_count, global_position)

			queue_free()
		
		else:
			sprite.modulate = damage_modulate
			await get_tree().process_frame
			await get_tree().process_frame
			await get_tree().process_frame
			sprite.modulate = Color.WHITE


func _on_child_entered_tree(node):
	if node is CactusSpike:
		spike_count += 1

func _ready():
	contact_monitor = true
	max_contacts_reported = 10000 # arbitraily large

func _on_body_entered(body:Node):
	#print("collision with ", body)
	if body is TileMap:
		#print("wall damage")
		wall_damaged.emit()
		take_damage(linear_velocity.length() / 8.0)


@onready var front_on_screen_notifier := %FrontOnScreenNotifier
func _on_on_screen_check_timer_timeout():
	if not front_on_screen_notifier.is_on_screen():
		queue_free()



func _on_rear_on_screen_notifier_screen_entered():
	collision_mask = collision_mask | (1 << 0) # world is layer 1, therefore shl (1 - 1)
