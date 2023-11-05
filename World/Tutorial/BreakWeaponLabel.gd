extends Label

func _on_node_removed(node: Node):
	if node is Weapon:
		queue_free()

func _ready():
	get_tree().node_removed.connect(_on_node_removed)
