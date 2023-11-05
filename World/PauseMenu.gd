extends PanelContainer

func unpause():
	visible = false
	get_tree().paused = false


func _input(event: InputEvent):
	if event.is_action_pressed("pause"):
		get_viewport().set_input_as_handled()
		unpause()


func _on_button_pressed():
	unpause()

