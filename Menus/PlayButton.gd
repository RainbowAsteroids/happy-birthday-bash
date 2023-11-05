extends Button

var play_scene := load("res://World/world.tscn")


func _on_pressed():
	get_tree().change_scene_to_packed(play_scene)
