#"option3":"YOU MONSTER!",
		#"yesTags":["MEAN", "HITSKIDS"],
		#"noTags":["NICE"],
		#"option3Tags":["NICE"],
		
extends Node2D

@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var youMonster = $YOUMONSTER;
@onready var parent = get_parent()

		
func _ready():
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);
	youMonster.pressed.connect(_you_monster_pressed)

func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
	noButton.hide()
	$Icecream.hide()
	parent.modifyInventory("ICECREAM");	
	
func _no_pressed():
	parent._no_pressed()
	yesButton.hide()
	noButton.hide()
	
func _you_monster_pressed():
	parent._option_3_pressed();
