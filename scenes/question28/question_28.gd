extends Node

@onready var phoneReciever = $PhoneReciever
@onready var phoneBase = $PhoneBase

func _ready() -> void:
	var scale = Vector2(0.1, 0.1)

	phoneReciever.scale(scale)
	phoneBase.scale(scale)
	$FiftyFifty.pressed.connect(_fifty_pressed)
	$PhoneAFriend.pressed.connect(_phone_a_friend_pressed)


func _fifty_pressed():
	$PhoneAFriend.hide()
	$FiftyFifty.hide()
	
func _phone_a_friend_pressed():
	$PhoneAFriend.hide()
	$FiftyFifty.hide()
	#modulate.a = 0.0
	var tween1 = create_tween()
	var tween2 = create_tween()



	tween1.tween_property(phoneReciever, "scale", Vector2(1, 1), 1.0).set_trans(Tween.TRANS_SINE)
	tween1.parallel().tween_property(phoneReciever, "modulate:a", 1.0, 1.0)
	
	tween2.tween_property(phoneBase, "scale", Vector2(1, 1), 1.0).set_trans(Tween.TRANS_SINE)
	tween2.parallel().tween_property(phoneBase, "modulate:a", 1.0, 1.0)

	
