extends Node2D

#"yesTags":["PANIC", "WIN"],
		#"noTags":["LOSE"],
		#"onQuestion": {"setTimer": 10,
		#RUTABAGA IN SCROLL BOX

@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var youMonster = $YOUMONSTER;
@onready var parent = get_parent()

		
func _ready():
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);
	

func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
	noButton.hide()
		
func _no_pressed():
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
	
