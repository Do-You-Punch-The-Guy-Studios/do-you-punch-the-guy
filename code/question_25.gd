extends Node2D
@onready var punchAudio = preload("res://assets/sound/797925__artninja__tmnt_2012_brad_myers_inspired_punches_04072025.wav")
@onready var audioPlayer = $AudioStreamPlayer2D;

func _ready() -> void:
	await get_tree().create_timer(.25, true).timeout
	var t = create_tween().set_parallel(true)
	t.tween_property($GuyPunchesBackFist, "scale", Vector2(1,1), .5)	
	await get_tree().create_timer(.25).timeout
	audioPlayer.stream = punchAudio
	audioPlayer.play()
	await get_tree().create_timer(.25).timeout
	$PowEffect.show();
	await get_tree().create_timer(.25).timeout
	$PowEffect.hide();
	await get_tree().create_timer(.25).timeout
	var t2 = create_tween().set_parallel(true)
	t2.tween_property($GuyPunchesBackFist, "scale", Vector2(0,0), .5)
