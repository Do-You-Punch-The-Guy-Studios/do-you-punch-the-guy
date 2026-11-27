extends TextureButton

@onready var parent = get_tree().current_scene;

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		parent.modifyInventory('add', "RUTABAGA");
		hide()
