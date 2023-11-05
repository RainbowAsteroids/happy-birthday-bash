extends Label

var weapon_count = 2

func _on_node_added(node: Node):
	if node is Weapon:
		weapon_count -= 1

		if weapon_count <= 0:
			queue_free()

func _on_node_removed(node: Node):
	if node is Weapon:
		weapon_count += 1

func _ready():
	get_tree().node_added.connect(_on_node_added)
	get_tree().node_removed.connect(_on_node_removed)
