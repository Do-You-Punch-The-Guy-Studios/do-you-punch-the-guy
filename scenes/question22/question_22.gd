extends Node2D

#"22": {
		
		#"yesTags":["ASSHOLE"],
		
	#},
@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var taco = $Tacos;
@onready var parent = get_parent()

		
func _ready():
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);
	taco.pressed.connect(_taco_pressed)

func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
	noButton.hide()
	$Icecream.hide()
	parent.modifyInventory("TACO");	
	
func _no_pressed():
	parent._no_pressed()
	yesButton.hide()
	noButton.hide()
	
func _taco_pressed():
	parent._option_3_pressed();
