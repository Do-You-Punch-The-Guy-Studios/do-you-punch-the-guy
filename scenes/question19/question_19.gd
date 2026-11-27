extends Node2D
	
@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var audioPlayer = $AudioStreamPlayer2D;
@onready var zombieBite = preload("res://scenes/question19/assets/400174__jgriffie919__flesh-bite.wav")
@onready var parent = get_parent()

		
func _ready():
	parent.setTimer(30)
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);

func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
	noButton.hide()
	await get_tree().create_timer(.25).timeout
	$theAction/ZombietheGuyface.hide();
	$theAction/TheGuyStump.show();
	
func _no_pressed():
	parent._no_pressed()
	parent._gameLoss("noFist")
	yesButton.hide()
	noButton.hide()
