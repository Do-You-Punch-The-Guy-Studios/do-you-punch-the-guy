extends Node2D

@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var rutabaga = $Rutabaga;
@onready var parent = get_parent()

		#"#yesTags":["ASSHOLE"],
		#"option3Tags":["RUTABAGA"],
		
func _ready():
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);
	rutabaga.pressed.connect(_rutabaga_pressed)

func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
	noButton.hide()
	
func _no_pressed():
	parent._no_pressed()
	yesButton.hide()
	noButton.hide()
	
func _rutabaga_pressed():
		parent.modifyInventory("RUTABAGA");
