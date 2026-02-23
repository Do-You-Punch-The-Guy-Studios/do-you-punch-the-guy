extends Node2D

@onready var explosion1 = $Explosion1;
@onready var explosion2 = $Explosion2;
@onready var audioPlayer = $AudioStreamPlayer2D;
@onready var explosion1Audio = preload("res://assets/sound/336009__rudmer_rotteveel__sharp-explosion-weird_natural_reverb.wav")
@onready var explosion2Audio = preload("res://assets/sound/560575__theplax__explosion-4.wav")


func _ready() -> void:
	await get_tree().create_timer(.5).timeout
	explosion1.show();
	audioPlayer.stream = explosion1Audio
	audioPlayer.play()
	var t = create_tween().set_parallel(true)
	t.tween_property(explosion1, "scale", Vector2(.1,.1), .5)
	await get_tree().create_timer(.5).timeout
	explosion1.hide();
	await get_tree().create_timer(1).timeout
	explosion2.show();
	audioPlayer.stream = explosion2Audio
	audioPlayer.play()
	var t2 = create_tween().set_parallel(true)
	t2.tween_property(explosion2, "scale", Vector2(.1,.1), .5)
	await get_tree().create_timer(.5).timeout
	explosion2.hide();

	
