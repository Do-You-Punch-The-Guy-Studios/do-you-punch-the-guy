extends Node2D

@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var theGuyFaceSprite = $theAction/TheGuyface;
@onready var theGuyFacePunchedSprite = $theAction/TheGuyfacePunched;
@onready var parent = get_parent()
@onready var grailSound = preload("res://scenes/question18/assets/648212__philip_berger__ui-sounds-shimmering-success.wav")
@onready var grailAudioPlayer = $GrailAudio

func _ready():
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);

func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
	noButton.hide()
	await get_tree().create_timer(.25).timeout
	theGuyFaceSprite.hide();
	theGuyFacePunchedSprite.show();
	grailAudioPlayer.stream = grailSound
	grailAudioPlayer.play()
	parent.modifyInventory('add', "HOLYGRAIL");
	
func _no_pressed():
	parent._no_pressed()
	yesButton.hide()
	noButton.hide()
