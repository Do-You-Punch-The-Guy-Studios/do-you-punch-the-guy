extends Node

var currentQuestionIndex = 0;
var currentQuestion: Variant;
var nextQuestionIndex  = 1 ;
var questionIndexes: Array = []
var rng = RandomNumberGenerator.new()
var questionInfo = {}

@onready var theShop = preload("res://shared/scenes/shop/theShop.tscn")
@onready var questionScenes = {
	"question1":preload("res://scenes/question1/question1.tscn"), 
	"question2":preload("res://scenes/question2/question2.tscn"), 
	"question3":preload("res://scenes/question3/question3.tscn"),
	"question4":preload("res://scenes/question4/question4.tscn"),
	"question5":preload("res://scenes/question5/question5.tscn"),
	"question6":preload("res://scenes/question6/question6.tscn"),
	"question7":preload("res://scenes/question7/question7.tscn"),
	"question8":preload("res://scenes/question8/question8.tscn"),
	"question9":preload("res://scenes/question9/question9.tscn"),
	"question10":preload("res://scenes/question10/question10.tscn"),
	"question11":preload("res://scenes/question11/question11.tscn"),
	"question12":preload("res://scenes/question12/question12.tscn"),
	"question13":preload("res://scenes/question13/question13.tscn"),
	"question14":preload("res://scenes/question14/question14.tscn"),
	"question15":preload("res://scenes/question15/question15.tscn"),
	"question16":preload("res://scenes/question16/question16.tscn"),
	"question17":preload("res://scenes/question17/question17.tscn"),
	"question18":preload("res://scenes/question18/question18.tscn"),
	"question19":preload("res://scenes/question19/question19.tscn"),
	"question20":preload("res://scenes/question20/question20.tscn"),
	"question21":preload("res://scenes/question21/question21.tscn"),
	"question22":preload("res://scenes/question22/question22.tscn"),
	"question23":preload("res://scenes/question23/question23.tscn"),
	"question24":preload("res://scenes/question24/question24.tscn"),
	"question25":preload("res://scenes/question25/question25.tscn"),
	"question26":preload("res://scenes/question26/question26.tscn"),
	"question27":preload("res://scenes/question27/question27.tscn"),
	"question28":preload("res://scenes/question28/question28.tscn"),
	"question29":preload("res://scenes/question29/question29.tscn"),
	"question30":preload("res://scenes/question30/question30.tscn"),
	"question31":preload("res://scenes/question31/question31.tscn"),
	"question32":preload("res://scenes/question32/question32.tscn"),
	"question33":preload("res://scenes/question33/question33.tscn"),

	};
@onready var nextButton = $NextButton;
@onready var punchArmScene = $PunchArmScene;
#@onready var timerText = $TimerText;
#@onready var timer = $TimerText/Timer;
#@onready var theQuestion = $ScrollContainer/Question;

#@onready var theGuyFaceSprite = $theAction/TheGuyface;
#@onready var theGuyFacePunchedSprite = $theAction/TheGuyfacePunched;

func _ready():
	nextButton.pressed.connect(_nextButtonPressed);
	rng.randomize()

	for i in range(2, 32):
		questionIndexes.append(i);
	
	questionIndexes.shuffle();
	changeQuestion();
	
#func _process(_delta):
	#if(timerText && timerText.visible):
		#timerText.text = "%02d:%02d" % timeLeft()

	
#func timeLeft():
	#var time_left = timer.time_left;
	#var minute = floor(time_left / 60)
	#var seconds = int(time_left) % 60
	#return [minute, seconds]

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
	currentQuestionIndex =1;
	print("question" + str(currentQuestionIndex));
	self.add_child(questionScenes["question" + str(currentQuestionIndex)].instantiate())
	
func _yes_pressed():
	punchArmScene.animatePunch()
	await get_tree().create_timer(.25).timeout
	#tallyResults('yes', questionNumber);
	nextButton.show();
	
func _no_pressed():

	#tallyResults('no', questionNumber)
	nextButton.show()
	
func _option_3_pressed():

	#tallyResults('option3', questionNumber)
	nextButton.show()
	
func _nextButtonPressed():
	nextButton.hide()
	changeQuestion()
		
func openShop(shop):
	punchArmScene.hide();
	$Question.hide();
	self.add_child(theShop.instantiate());
	$TheShop.stockItems(shop);
		
func modifyInventory(addOrRemove: String, itemName: String):
	if(addOrRemove == 'add'):
		if(!$PlayerInventory.visible):
			$PlayerInventory.show();
	$PlayerInventory.updateInventory(addOrRemove, itemName);
	

#func setTimer(numberOfSeconds):
		#timer.wait_time = numberOfSeconds
		#timer.one_shot = true
		#timer.timeout.connect(_on_timer_timeout)
		#timerText.show()
		#timer.start()
		#


#func _on_timer_timeout():
	#_gameLoss()
	#
#func _gameLoss():
	#self.add_child(questionScenes["question25"].instantiate())
	#$YouLosePow.show();
	#$YouLosePow/YouLoseLabel.show();
 
