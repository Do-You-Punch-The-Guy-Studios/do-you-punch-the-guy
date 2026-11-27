extends Node2D

	#"19": {
		#"yesTags":["PANIC"],
		#"noTags":["LOSE"],
	#},
	
	
@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var parent = get_parent()

		
func _ready():
	parent.setTimer(30)
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);

func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
	noButton.hide()
	$Question19/ZombietheGuyface.hide();
	$Question19/TheGuyStump.show();
	
func _no_pressed():
	parent._no_pressed()
	yesButton.hide()
	noButton.hide()
