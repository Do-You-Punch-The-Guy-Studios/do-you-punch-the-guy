extends Node2D

#"20": {
		#"question":"",
		#"yes": true,
		#"no": true,
		#"option3": false,
		#"yesTags":[],
		#"noTags":[],
		#"onQuestion": false,
		#"onYes": false,
		#"onNo": false,
		#"isActive": true
	#},
@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var parent = get_parent()

		
func _ready():
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
	
