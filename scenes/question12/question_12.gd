extends Node2D

@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var tysonFace = $MikeTysonFace
@onready var tysonPunched = $MikeTysonHurtFace
@onready var parent = get_parent()

		#"yesTags":["WIN"],
		#"noTags":["LOSE"],
		#"onYes": {"animate":"TysonTKO",},
		#"onNo": {"animate":"TysonPunch",},

func _ready():
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);

func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
	noButton.hide()
	await get_tree().create_timer(.25).timeout
	tysonFace.hide();
	tysonPunched.show();
	
func _no_pressed():
	parent._no_pressed()
	parent._gameLoss("tyson")
	yesButton.hide()
	noButton.hide()
