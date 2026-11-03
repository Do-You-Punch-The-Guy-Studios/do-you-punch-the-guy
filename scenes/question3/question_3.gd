extends Node2D

@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var parent = get_parent()


	#"yesTags":["BARFIGHT", "MEAN"],
		#"noTags":["PARTY"],
func _ready():
	parent.modifyInventory("BEER");
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
