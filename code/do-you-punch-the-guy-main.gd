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
var currentQuestionIndex;
var currentQuestion: Variant;
var nextQuestionIndex  = 1 ;
var questionIndexes: Array = []
var rng = RandomNumberGenerator.new()
@onready var questionScenes = {"question2":preload("res://scenes/question2.tscn")};
@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var option3button = $"Option 3";
@onready var nextButton = $NextButton;
@onready var punchArm = $theAction/PunchArm;

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
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);
	option3button.pressed.connect(_option_3_pressed);
	nextButton.pressed.connect(_nextButtonPressed);
	option3button.hide();
	rng.randomize()

	for i in range(2, 101):
		questionIndexes.append(i);
	
	questionIndexes.shuffle();
	changeQuestion();
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func changeQuestion() -> void:
	if questionIndexes.is_empty():
		print("All numbers have been used!");
		
	currentQuestionIndex = nextQuestionIndex
	nextQuestionIndex = questionIndexes.back()
	questionIndexes.pop_back()
	currentQuestionIndex = 1;
	currentQuestion = questionInfo[currentQuestionIndex];
	if(currentQuestionIndex > 1):
		self.add_child(questionScenes["question" + str(currentQuestionIndex)].instantiate())
	$Question.text = "Question" + str(currentQuestionIndex) + ": " + currentQuestion.question
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
		option3button.show()
	#TODO modify the visuals
	
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
	yesButton.hide()
	noButton.hide()
	option3button.hide()
	animatePunch()
	tallyResults('yes')
	nextButton.show()
	
func _no_pressed():
	yesButton.hide()
	noButton.hide()
	option3button.hide()
	#animateNoPunchIfNeeded()
	tallyResults('no')
	nextButton.show()
	
func _option_3_pressed():
	yesButton.hide()
	noButton.hide()
	option3button.hide()
	#animateOption3IfNeeded()
	tallyResults('option3')
	nextButton.show()
	
func _nextButtonPressed():
	nextButton.hide()
	changeQuestion()
	
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
				if(rudabega == 10):
					secretRudabegaLevel()
				
func secretRudabegaLevel():
	print("Secret Rudabega Level")
				
func _gameLoss():
	print("you lose!")
	
func winTheGame():
	print("win")
	
var questionInfo: Dictionary[int, Variant] = {
	1: {
		"question":"Do you punch the guy?",
		"yes": true,
		"no": true,
		"option3": false,
		"yesTags":[Tags.WIN],
		"noTags":[Tags.LOSE],
		"isActive":true
	},	
	2: {
		"question":"A guy walks by with a large bundle of balloons, do you punch the guy?",
		"yes": true,
		"no": true,
		"option3":false,
		"yesTags":[Tags.HITSKIDS, Tags.ASSHOLE],
		"noTags":[Tags.NICE],
		"option3Tags":[],
		"special":{},
		"isActive": true
	},	
}
