extends Node2D
@onready var punchArm = $theAction/PunchArm;
@onready var powEffectSprite = $theAction/PowEffect;
@onready var punchAudio = preload("res://shared/assets/sound/797925__artninja__tmnt_2012_brad_myers_inspired_punches_04072025.wav")
@onready var audioPlayer = $AudioStreamPlayer2D;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func animatePunch():
	var initialX = punchArm.position.x +2;
	var initialY = punchArm.position.y +4.5;
	var initialPosition = Vector2(initialX, initialY)
	var newYPosition = punchArm.position.y - 250;
	var newXPosition = punchArm.position.x - 100;
	var newPosition = Vector2(newXPosition, newYPosition )

	punchArm.position = punchArm.position.lerp(newPosition, 1 - exp(-4))
	
	audioPlayer.stream = punchAudio
	audioPlayer.play()
	await get_tree().create_timer(.25).timeout
	#powEffectSprite.show();
	#theGuyFaceSprite.hide();
	#theGuyFacePunchedSprite.show();
	await get_tree().create_timer(.25).timeout
	#powEffectSprite.hide();
	await get_tree().create_timer(.25).timeout
	punchArm.position = punchArm.position.lerp(initialPosition, 1 - exp(-4))
