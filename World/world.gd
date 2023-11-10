class_name World extends Node2D

@export var pause_menu: CanvasItem

@export var shop_button_parent: Node
@export var balance_label: Label
@export var lose_screen: PackedScene

@export var gold_scene: PackedScene

@export var balance := 1: 
	set(value):
		balance_label.text = str(value)

		balance = value

var shop_buttons: Array[ShopButton] = []
var stick_button: ShopButton

func _input(event: InputEvent):
	if event.is_action_pressed("pause"):
		pause_menu.visible = true
		get_tree().paused = true

func _on_selected(button: ShopButton):
	var cost = button.price

	if cost <= balance:
		shuffle_shop()

		balance -= cost

		var weapon := button.weapon_scene.instantiate() as Weapon
		weapon.global_position = MousePos.mouse_pos

		add_child(weapon)
		weapon.set_moving(true)


func shuffle_shop():
	for btn in shop_buttons:
		btn.visible = false
	stick_button.visible = false

	var spots_left = 2
	var stick_placed = false
	
	var btns := shop_buttons.duplicate()

	for i in range(3):
		if not stick_placed:
			if randi() % (spots_left + 1) == 0:
				stick_placed = true
				stick_button.visible = true
				stick_button.get_parent().move_child(stick_button, i)
				continue
			else:
				spots_left -= 1

		btns.shuffle()
		var btn := btns.pop_back() as ShopButton
		btn.visible = true
		btn.get_parent().move_child(btn, i)


func _ready():
	HighscoreManager.reset()

	get_tree().node_added.connect(_on_node_added)

	balance = balance

	for node in shop_button_parent.get_children():
		if node.stick:
			stick_button = node
		else:
			shop_buttons.append(node)

		node.selected.connect(_on_selected)

	shuffle_shop()

func _on_collected():
	HighscoreManager.score += 1
	balance += 1

func _on_create_gold(amount: int, pos: Vector2):
	for i in range(amount):
		var gold = gold_scene.instantiate()
		gold.global_position = pos
		gold.global_rotation = randf() * PI * 2
		add_child.call_deferred(gold)

func _on_node_added(node:Node):
	if node is Gold:
		node.collected.connect(_on_collected)

	if node is Enemy:
		node.create_gold.connect(_on_create_gold)
		

func _on_cake_dead():
	HighscoreManager.commit()
	get_tree().change_scene_to_packed(lose_screen)

