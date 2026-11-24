extends Node2D
@onready var timer = $Timer;
@onready var logo = $Logo;
@onready var logoSmall = $LogosMALL
@onready var studios = $Studios
@onready var theGuyFace = $TheGuyface;
@onready var theGuyBody = $TheGuyBody;
@onready var doYouPunch = $ADoYouPunchTheGuyGame;
@onready var logoAnimationPlayer = $Logo/LogoAnimationPlayerr;
@onready var gameAnimationPlayer = $ADoYouPunchTheGuyGame/GameAnimationPlayer;
@onready var studiosAnimationPlayer = $Studios/StudiosAnimationPlayer;
@onready var newGameButton = $newGameButton;
@onready var levelSelectButton = $LevelSelectButton;
@onready var achevementsButton = $AchevementsButton;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	newGameButton.pressed.connect(_newGame);
	#noButton.pressed.connect(_no_pressed);
	#option3button.pressed.connect(_option_3_pressed);
	studiosAnimationPlayer.play("studiosFade")
	setTimer(3,logoAnimationPlayer.play("logoAnimation") )
	setTimer(3, gameAnimationPlayer.play("gameAnimation") )
	displayMenu()

func setTimer(numberOfSeconds, onTimeoutCallback):
		timer.wait_time = numberOfSeconds
		timer.one_shot = true
		timer.timeout.connect(onTimeoutCallback)
		timer.start()

func displayMenu():
	theGuyFace.show()
	theGuyBody.show()
	$newGameButton.show()
	$AchevementsButton.show()
	$LevelSelectButton.show()
	
func _newGame():
	get_tree().change_scene_to_file("res://scenes/the-guy-root-scene/the-guy-root-scene.tscn")
	
