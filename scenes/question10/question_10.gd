extends Node2D

@onready var yesButton = $YesButton;
@onready var parent = get_parent()

#		"yesTags":["UNDERSTANDABLE"],


func _ready():
	yesButton.pressed.connect(_yes_pressed);

func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
