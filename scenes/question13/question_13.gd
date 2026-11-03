extends Node2D

@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var parent = get_parent()

		#		"yesTags":["UNDERSTANDABLE", "MEAN", "HITSKIDS"],


func _ready():
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);

func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
	noButton.hide()
	$Question13/Purpledinoface.hide();
	$Question13/PurpleDinoPunched.show();
	
func _no_pressed():
	parent._no_pressed()
	yesButton.hide()
	noButton.hide()
