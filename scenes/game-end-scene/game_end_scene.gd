extends Node2D

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

@onready var parent = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	calculateResults(parent.choices);


func calculateResults(choices: Array):
	var i = 1
	for choice in choices:
			#"yesTags":["WIN"],
		#"noTags":["LOSE"],
		i += 1
