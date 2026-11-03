extends Node2D

	#"23": {
		#"yesTags":["ASSHOLE", "BARFIGHT"],
	
		#"onOption3":{"shop":[{"item":"BEER", "quantity": 1}, {"item":"PUNCH", "quantity": 1}], "inventory": false, "animate": false, "setTimer":false},
		#"onQuestion": "lightswitchRave", "setTimer":false},
	#},
	
@onready var yesButton = $YesButton;
@onready var noButton = $NoButton;
@onready var taco = $Tacos;
@onready var parent = get_parent()
var lightswitchRave = false;

		
func _ready():
	yesButton.pressed.connect(_yes_pressed);
	noButton.pressed.connect(_no_pressed);
	taco.pressed.connect(_taco_pressed)
	
func _process(_delta):
	doLightswitchRave()


func _yes_pressed():
	parent._yes_pressed()
	yesButton.hide()
	noButton.hide()
	$Icecream.hide()
	parent.modifyInventory("TACO");	
	
func _no_pressed():
	parent._no_pressed()
	yesButton.hide()
	noButton.hide()
	
func _taco_pressed():
	parent._option_3_pressed();
	
func doLightswitchRave():
	lightswitchRave = false;
	$background.color = Color("#000000")
	await get_tree().create_timer(0.1).timeout
	$background.color = Color("#FED689")
	await get_tree().create_timer(0.1).timeout
	$background.color = Color("#88FF89")
	await get_tree().create_timer(0.1).timeout
	$background.color = Color("#83FCFE")
	await get_tree().create_timer(0.1).timeout
	$background.color = Color("#8BB5FE")
	await get_tree().create_timer(0.1).timeout
	$background.color = Color("#D78CFF")
	await get_tree().create_timer(0.1).timeout
	$background.color = Color("#FF8CFF")
	await get_tree().create_timer(0.1).timeout
	$background.color = Color("#D78CFF")
	await get_tree().create_timer(0.1).timeout
	$background.color = Color("#8BB5FE")
	await get_tree().create_timer(0.1).timeout
	$background.color = Color("#83FCFE")
	await get_tree().create_timer(0.1).timeout
	$background.color = Color("#88FF89")
	await get_tree().create_timer(0.1).timeout
	$background.color = Color("#FED689")
	await get_tree().create_timer(0.1).timeout
	$background.color = Color("#000000")
	lightswitchRave = true;
