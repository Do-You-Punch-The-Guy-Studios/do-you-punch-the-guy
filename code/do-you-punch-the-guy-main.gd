extends Node

var timesTheGuyWasPunched = 0
var isAsshole = 0
var isNice = 0
var hitsKids = 0
var hitsAdult = 0
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

func _ready() -> void:
	$"YesButton".pressed.connect(_yes_pressed)
	$"NoButton".pressed.connect(_no_pressed)
	$"Option 3".pressed.connect(_option_3_pressed)
	$NextButton.pressed.connect(_nextButtonPressed)
	$"Option 3".hide();
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
	currentQuestion = questionInfo[currentQuestionIndex];
	$Question.text = "Question" + str(currentQuestionIndex) + ": " + currentQuestion.question
	if !currentQuestion.yes:
		$"YesButton".hide()
	else:
		$"YesButton".show()
	if !currentQuestion.no:
		$"NoButton".hide()
	else:
		$"NoButton".show()
	if !currentQuestion.option3:
		$"Option 3".hide()
	else:
		$"Option 3".show()
	#TODO modify the visuals
	
func animatePunch():
	var initialX = $theAction/PunchArm.position.x;
	var initialY = $theAction/PunchArm.position.y;
	var initialPosition = Vector2(initialX, initialY)
	var newYPosition = $theAction/PunchArm.position.y - 250;
	var newXPosition = $theAction/PunchArm.position.x - 100;
	var newPosition = Vector2(newXPosition, newYPosition )

	$theAction/PunchArm.position = $theAction/PunchArm.position.lerp(newPosition, 1 - exp(-4))
	await get_tree().create_timer(.25).timeout
	$theAction/PowEffect.show();
	$theAction/TheGuyface.hide();
	$theAction/TheGuyfacePunched.show();	
	await get_tree().create_timer(.25).timeout
	$theAction/PowEffect.hide();
	await get_tree().create_timer(.25).timeout
	$theAction/PunchArm.position = $theAction/PunchArm.position.lerp(initialPosition, 1 - exp(-4))
	
func _yes_pressed():	
	$"YesButton".hide()
	$"NoButton".hide()
	$"Option 3".hide()
	animatePunch()
	tallyResults('yes')
	$NextButton.show()
	
func _no_pressed():
	$"YesButton".hide()
	$"NoButton".hide()
	$"Option 3".hide()
	#animateNoPunchIfNeeded()
	tallyResults('no')
	$NextButton.show()
	
func _option_3_pressed():
	$"YesButton".hide()
	$"NoButton".hide()
	$"Option 3".hide()
	#animateOption3IfNeeded()
	tallyResults('option3')
	$NextButton.show()
	
func _nextButtonPressed():
	$NextButton.hide()
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
			Tags.HITSADULTS:
				hitsAdult += 1
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
		"yesTags":["child", "mean"],
		"noTags":["nice"],
		"option3Tags":[],
		"special":{},
		"isActive": true
	},	
}
