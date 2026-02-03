extends Node

var timesTheGuyWasPunched = 0
var isAsshole = 0
var isNice = 0
var hitsKids = 0
var barfight = 0
var rudabega = 0
var win = 0
var panic = 0
var space = 0
var understandable = 0
var crime = 0
var party = 0
var currentQuestionIndex = 0;
var currentQuestion: Variant;
var nextQuestionIndex  = 1 ;
var questionIndexes: Array = []
var rng = RandomNumberGenerator.new()
var questionInfo = {}
var playerInventory: = [];
var alreadyDoneThis = false;

@onready var questionScenes = {
	"question2":preload("res://scenes/question2.tscn"), 
	"question3":preload("res://scenes/question3.tscn"),
	"question4":preload("res://scenes/question4.tscn"),
	"question5":preload("res://scenes/question5.tscn"),
	"question6":preload("res://scenes/question6.tscn"),
	"question7":preload("res://scenes/question7.tscn"),
	"question8":preload("res://scenes/question8.tscn"),
	"question9":preload("res://scenes/question9.tscn"),
	"question10":preload("res://scenes/question10.tscn"),
	"question11":preload("res://scenes/question11.tscn"),
	"question12":preload("res://scenes/question12.tscn"),
	"question13":preload("res://scenes/question13.tscn"),
	"question14":preload("res://scenes/question14.tscn"),
	"question15":preload("res://scenes/question15.tscn"),
	"question16":preload("res://scenes/question16.tscn"),
	"question17":preload("res://scenes/question17.tscn"),
	"question18":preload("res://scenes/question18.tscn"),
	};
@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var option3button = $"Option 3";
@onready var nextButton = $NextButton;
@onready var punchArm = $theAction/PunchArm;
@onready var timerText = $TimerText;
@onready var timer = $TimerText/Timer;

enum Tags {  
	ASSHOLE,
	NICE,
	HITSKIDS,
	HITSADULTS,
	BARFIGHT,
	RUDABEGA,
	WIN,
	PANIC,
	SPACE,
	UNDERSTANDABLE,
	CRIME,
	PARTY,
	LOSE
}  

func _ready():
	loadQuestions();
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);
	option3button.pressed.connect(_option_3_pressed);
	nextButton.pressed.connect(_nextButtonPressed);
	option3button.hide();
	rng.randomize()

	for i in range(2, 17):
		questionIndexes.append(i);
	
	questionIndexes.shuffle();
	changeQuestion();
	
func _process(_delta):
	if(timerText && timerText.visible):
		timerText.text = "%02d:%02d" % timeLeft()
	
func timeLeft():
	var time_left = timer.time_left;
	var minute = floor(time_left / 60)
	var seconds = int(time_left) % 60
	return [minute, seconds]
	
func loadQuestions():
	var filePath = "res://data/questions.json"
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		questionInfo = JSON.parse_string(dataFile.get_as_text())

func changeQuestion() -> void:
	if(currentQuestionIndex > 1):
		var path = "Question%d" % currentQuestionIndex
		var node = get_node_or_null(path)
		if(node):
			node.queue_free()
	if questionIndexes.is_empty():
		print("All numbers have been used!");
		
	currentQuestionIndex = nextQuestionIndex
	nextQuestionIndex = questionIndexes.back()
	questionIndexes.pop_back()
	currentQuestionIndex =16;
	currentQuestion = questionInfo[str(currentQuestionIndex)];
	if(currentQuestionIndex > 1):
		self.add_child(questionScenes["question" + str(currentQuestionIndex)].instantiate())
	if currentQuestion.onQuestion:
		processGameAction(currentQuestion.onQuestion)
	$ScrollContainer/Question.text = "Question " + str(currentQuestionIndex) + ": " + currentQuestion.question
	if !currentQuestion.yes:
		yesButton.hide()
	else:
		yesButton.show()
	if !currentQuestion.no:
		noButton.hide()
	else:
		noButton.show()
	if !currentQuestion.option3:
		option3button.hide()
	else:
		option3button.text = currentQuestion.option3
		option3button.show()
	
func animatePunch():
	var initialX = punchArm.position.x;
	var initialY = punchArm.position.y;
	var initialPosition = Vector2(initialX, initialY)
	var newYPosition = punchArm.position.y - 250;
	var newXPosition = punchArm.position.x - 100;
	var newPosition = Vector2(newXPosition, newYPosition )

	punchArm.position = punchArm.position.lerp(newPosition, 1 - exp(-4))
	await get_tree().create_timer(.25).timeout
	$theAction/PowEffect.show();
	$theAction/TheGuyface.hide();
	$theAction/TheGuyfacePunched.show();
	await get_tree().create_timer(.25).timeout
	$theAction/PowEffect.hide();
	await get_tree().create_timer(.25).timeout
	punchArm.position = punchArm.position.lerp(initialPosition, 1 - exp(-4))
	
func _yes_pressed():
	timer.stop()
	yesButton.hide()
	noButton.hide()
	option3button.hide()
	animatePunch()
	if (currentQuestion.onYes):
		await get_tree().create_timer(0.5).timeout
		processGameAction(currentQuestion.onYes)
	tallyResults('yes')
	#SHOW TEARDOWN TEXT
	nextButton.show()
	
func _no_pressed():
	timer.stop()
	yesButton.hide()
	noButton.hide()
	option3button.hide()
	if (currentQuestion.onNo):
		processGameAction(currentQuestion.onNo)
	tallyResults('no')
	#SHOW TEARDOWN TEXT
	nextButton.show()
	
func _option_3_pressed():
	timer.stop()
	yesButton.hide()
	noButton.hide()
	option3button.hide()
	if currentQuestion.onOption3:
		processGameAction(currentQuestion.onOption3)
	#animateOption3IfNeeded()
	
	tallyResults('option3')
	#SHOW TEARDOWN TEXT
	nextButton.show()
	
func _nextButtonPressed():
	nextButton.hide()
	timerText.hide()
	$theAction/TheGuyface.show();
	$theAction/TheGuyfacePunched.hide();
	changeQuestion()
	
func processGameAction(gameActions: Dictionary):
	if(gameActions.inventory):
		modifyInventory('add', gameActions.inventory)
	if(gameActions.animate):
		animateScene(gameActions.animate)
	if(gameActions.setTimer):
		setTimer(gameActions.setTimer)
		
func modifyInventory(addOrRemove: String, itemName: String):
	if(addOrRemove == 'add'):
		if(!$PlayerInventory.visible):
			$PlayerInventory.show();
		#playerInventory.append(itemName)
	#if(addOrRemove == 'remove'):
		#playerInventory.erase(itemName)
	$PlayerInventory.updateInventory(addOrRemove, itemName);
	
func animateScene(sceneName):
		if(sceneName == "TysonTKO"):
			$Question12/MikeTysonFace.hide();
			$Question12/MikeTysonHurtFace.show();
		if(sceneName == "PurpleDinoTKO"):
			$Question13/Purpledinoface.hide();
			$Question13/PurpleDinoPunched.show();
			
func setTimer(numberOfSeconds):
		timer.wait_time = numberOfSeconds
		timer.one_shot = true
		timer.timeout.connect(_on_timer_timeout)
		timerText.show()
		timer.start()
		
func tallyResults(buttonPressed: String):
	var tags
	if(buttonPressed == 'yes'):
		tags = currentQuestion.yesTags
	if(buttonPressed == 'no'):
		tags = currentQuestion.noTags
	if (buttonPressed == 'option3'):
		tags = currentQuestion.option3Tags
	if(tags):
		match tags:
			Tags.LOSE:
				_gameLoss()
			Tags.WIN:
				win += 1
				if(win > 10):
					winTheGame()
			Tags.ASSHOLE:
				isAsshole +=1
			Tags.NICE:
				isNice += 1
			Tags.HITSKIDS:
				hitsKids += 1
			Tags.BARFIGHT: 
				barfight += 1
			Tags.RUDABEGA:
				rudabega += 1
				
func getARutabaga():
	if !alreadyDoneThis:
		modifyInventory('add', "RUTABAGA")
		alreadyDoneThis = true;

				
func secretRudabegaLevel():
	#goToSecretRudabagaLevel
	print("Secret Rudabega Level")

func _on_timer_timeout():
	_gameLoss()
	
func _gameLoss():
	print("you lose!")
	
func winTheGame():
	#winTheGame
	print("win")
	
 
