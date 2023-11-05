extends Label

func _on_node_added(node: Node):
	if node is Weapon:
		queue_free()

func _ready():
	get_tree().node_added.connect(_on_node_added)
