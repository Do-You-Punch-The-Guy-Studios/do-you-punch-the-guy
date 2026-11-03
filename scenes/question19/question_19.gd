extends Node2D

	#"19": {
		#"yesTags":["PANIC"],
		#"noTags":["LOSE"],
	#},
	
	
@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var parent = get_parent()
@onready var timerText = $TimerText;
@onready var timer = $TimerText/Timer;

func _process(_delta):
	if(timerText && timerText.visible):
		timerText.text = "%02d:%02d" % timeLeft()
		
func _ready():
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
	
func setTimer():
	timer.wait_time = 30
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	timerText.show()
	timer.start()

func timeLeft():
	var time_left = timer.time_left;
	var minute = floor(time_left / 60)
	var seconds = int(time_left) % 60
	return [minute, seconds]
	
func _on_timer_timeout():
	parent._gameLoss()
