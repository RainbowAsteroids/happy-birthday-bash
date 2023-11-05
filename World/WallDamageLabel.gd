extends Label

func _on_wall_damaged():
	queue_free()

func _on_node_added(node: Node):
	if node is Enemy:
		node.wall_damaged.connect(_on_wall_damaged)

func _ready():
	get_tree().node_added.connect(_on_node_added)
