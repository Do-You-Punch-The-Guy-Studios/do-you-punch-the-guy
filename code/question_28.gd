extends Node

@onready var phoneReciever = $PhoneReciever
@onready var phoneBase = $PhoneBase

func _ready() -> void:
	$FiftyFifty.pressed.connect(_fifty_pressed)
	$PhoneAFriend.pressed.connect(_phone_a_friend_pressed)


func _fifty_pressed():
	$PhoneAFriend.hide()
	$FiftyFifty.hide()
	
func _phone_a_friend_pressed():
	$PhoneAFriend.hide()
	$FiftyFifty.hide()
	phoneReciever.show()
	phoneBase.show()
	
