extends Node2D
@onready var rutabaga = $ScrollContainer/VBoxContainer/Rutabaga
#"yesTags":["PANIC", "WIN"],
		#"noTags":["LOSE"],
		#"onQuestion": {"setTimer": 10,
		#RUTABAGA IN SCROLL BOX

@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var parent = get_parent()

		
func _ready():
	parent.setTimer(12)
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);
	

func _yes_pressed():
	rutabaga.hide()
	parent._yes_pressed()
	yesButton.hide()
	noButton.hide()
		
func _no_pressed():
	rutabaga.hide()
	parent._no_pressed()
	yesButton.hide()
	noButton.hide()
	
func on_scrollbar_input(value):
	var max_scroll_value = $ScrollContainer.scroll_vertical.max_value
	print(max_scroll_value)
	var container_height = $ScrollContainer.size.y
	if value >= max_scroll_value - container_height - 5:
		print('this')
			#playSound
		parent.modifyInventory('add', 'RUTABAGA')
	
