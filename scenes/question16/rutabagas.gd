extends Container

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var parent_node = get_parent().get_parent()
		if parent_node != null and parent_node.has_method("getARutabaga"):
			parent_node.getARutabaga()
