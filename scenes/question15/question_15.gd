extends Node2D

@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var youMonster = $YOUMONSTER;
@onready var theGuyFaceSprite = $theAction/TheGuyface;
@onready var theGuyFacePunchedSprite = $theAction/TheGuyfacePunched;
@onready var parent = get_parent()

		
func _ready():
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);
	youMonster.pressed.connect(_you_monster_pressed)

func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
	noButton.hide()
	youMonster.hide()
	await get_tree().create_timer(.25).timeout
	theGuyFaceSprite.hide();
	theGuyFacePunchedSprite.show();
	$Icecream.hide()
	parent.modifyInventory("add","ICECREAM");	
	
func _no_pressed():
	parent._no_pressed()
	yesButton.hide()
	noButton.hide()
	youMonster.hide()

	
func _you_monster_pressed():
	parent._option_3_pressed("YOUMONSTER");
	yesButton.hide()
	noButton.hide()
	youMonster.hide()
