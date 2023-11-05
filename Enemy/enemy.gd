class_name Enemy extends RigidBody2D

@export var damage := 3.0
@export var health := 100.0

@export var max_speed := 50.0
@export var acceleration := 15.0
@export var max_angular_velocity := 500.0
@export var torque := 5000.0

@export var correction_torque := 5000.0
@export var flick := 2.0
@export var yank := 500.0

@export var sprite: Node2D

@export var head_pos: Node2D

@export var damage_modulate := Color.RED

@export var gold_scene: PackedScene

@onready var cake := Cake.instance
@onready var initial_mass = mass

var dead = false

var damage_multiplier := 1.0

var slowed := false
var damage_multiplied := false

var spike_count = 1

func _physics_process(_delta):
	var goal := cake.global_position - global_position
	var goal_hat := goal.normalized()
	
	var angle := Vector2.RIGHT.rotated(rotation).angle_to(goal_hat)
	
	if sign(angle) != sign(angular_velocity):
		flick = 3.0

	#print(sign(angle) * sign(angular_velocity))

	var angle_accuracy = (2 - abs(abs(angle) - abs(rotation)) / PI) * flick

	var desired_direction = Vector2.RIGHT.rotated(angle)
	var f_hat = Vector2.RIGHT.rotated(rotation)

	var mul = (-(f_hat.dot(desired_direction) - 1) + 1) * flick
	
	apply_torque(sign(angle) * torque * angle_accuracy)
	#apply_central_force(Vector2.RIGHT.rotated(rotation) * acceleration * initial_mass)

	apply_central_force(f_hat * acceleration * initial_mass)
	#apply_central_force(f_hat * acceleration * initial_mass)

	if abs(angular_velocity) > max_angular_velocity:
		var delta_av = max_angular_velocity - abs(angular_velocity)
		apply_torque(correction_torque * -sign(angular_velocity))
	
	#velocity += goal * acceleration * delta
	#velocity = velocity.limit_length(max_speed)
	#move_and_slide()
	

func take_damage(amount: float):
	if not dead:
		health -= amount * damage_multiplier

		if health <= 0:
			dead = true

			for i in range(spike_count):
				var gold = gold_scene.instantiate()
				gold.global_position = global_position
				get_parent().add_child(gold)

				queue_free()
		
		sprite.modulate = damage_modulate
		await get_tree().process_frame
		await get_tree().process_frame
		await get_tree().process_frame
		sprite.modulate = Color.WHITE


func _on_child_entered_tree(node):
	if node is CactusSpike:
		spike_count += 1
