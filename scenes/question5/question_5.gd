extends Node2D

@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var parent = get_parent();
@onready var theGuyFaceSprite = $theAction/TheGuyface;
@onready var theGuyFacePunchedSprite = $theAction/TheGuyfacePunched;
@onready var rutabaga = $Rutabaga;

		#"#yesTags":["ASSHOLE"],
		#"option3Tags":["RUTABAGA"],
		
func _ready():
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);
	rutabaga.pressed.connect(_rutabaga_pressed)

#"yesTags":["ASSHOLE", "HITSKIDS"],


func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
	noButton.hide()
	rutabaga.hide()
	await get_tree().create_timer(.25).timeout
	theGuyFaceSprite.hide();
	theGuyFacePunchedSprite.show();
	
func _no_pressed():
	parent._no_pressed()
	yesButton.hide()
	noButton.hide()
	rutabaga.hide()
	
func _rutabaga_pressed():
	parent._option_3_pressed("Rutabaga")
	parent.modifyInventory("add", "RUTABAGA");
	yesButton.hide()
	noButton.hide()
	rutabaga.hide()
