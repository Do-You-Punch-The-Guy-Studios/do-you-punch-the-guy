extends Node2D
@onready var punchAudio = preload("res://shared/assets/sound/797925__artninja__tmnt_2012_brad_myers_inspired_punches_04072025.wav")
@onready var audioPlayer = $AudioStreamPlayer2D;
@onready var parent = get_parent()
var params = "";

func _ready() -> void:
	var fist = $GuyPunchesBackFist
	if params == "tyson":
		fist = $TysonFist
		fist.show();
		$GuyPunchesBackFist.hide()
	await get_tree().create_timer(.25, true).timeout
	var t = create_tween().set_parallel(true)
	t.tween_property(fist, "scale", Vector2(1,1), .5)	
	await get_tree().create_timer(.25).timeout
	audioPlayer.stream = punchAudio
	audioPlayer.play()
	await get_tree().create_timer(.25).timeout
	#lose unless you have an extra mans
	$YouLosePow.show();
	$YouLosePow/YouLoseLabel.show();
