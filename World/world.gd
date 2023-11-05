class_name World extends Node2D

@export var shop_button_parent: Node
@export var balance_label: Label

@export var balance := 5: 
	set(value):
		balance_label.text = str(value)

		balance = value

var shop_buttons: Array[ShopButton] = []
var stick_button: ShopButton

func _on_selected(button: ShopButton):
	var cost = button.price

	if cost <= balance:
		shuffle_shop()

		balance -= cost

		var weapon := button.weapon_scene.instantiate() as Weapon
		weapon.global_position = get_global_mouse_position()

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
	balance += 1

func _on_node_added(node:Node):
	if node is Gold:
		node.collected.connect(_on_collected)
		pass

