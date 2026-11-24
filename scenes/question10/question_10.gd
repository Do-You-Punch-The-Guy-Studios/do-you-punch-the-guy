extends Node2D

@onready var yesButton = $YesButton;
@onready var parent = get_parent()
@onready var theGuyFaceSprite = $theAction/TheGuyface;
@onready var theGuyFacePunchedSprite = $theAction/TheGuyfacePunched;
#		"yesTags":["UNDERSTANDABLE"],


func _ready():
	yesButton.pressed.connect(_yes_pressed);

func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
	await get_tree().create_timer(.25).timeout
	theGuyFaceSprite.hide();
	theGuyFacePunchedSprite.show();
