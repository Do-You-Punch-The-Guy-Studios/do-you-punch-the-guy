extends Container

@onready var parent = get_parent().get_parent();
@onready var didThis = false;

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	gui_input.connect(_gui_input)

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and !didThis :
		parent.modifyInventory('add', "RUTABAGA");
		didThis = true;
