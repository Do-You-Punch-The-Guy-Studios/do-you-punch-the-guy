extends Node2D

var tween: Tween

var assets = {"BEER":{}, "ICECREAM":{}, "PUNCH":{}, "RUTABAGA":{}, "TACO":{}, "HOLYGRAIL":{}, "GUY":{}}
var inventoryState = {"BEER":0, "ICECREAM":0, "PUNCH":0, "RUTABAGA":0, "TACO":0, "HOLYGRAIL":0, "GUY": 0, "TOTAL": 0}

@onready var inventoryContainer = $ScrollContainer/Inventory;

func updateInventory(addOrRemove: String, itemName: String):
	if(addOrRemove == "add"):
		if(inventoryState[itemName] == 0):
			addItemToInventory(itemName)
			createItemIconAndNumberAsset(itemName)
		else:
			updateItemNumberValue(itemName)
	elif(addOrRemove=="remove"):
		if(inventoryState[itemName] == 0):
			removeItemFromInventory(itemName)
			createItemIconAndNumberAsset(itemName)
		else:
			updateItemNumberValue(itemName)
		
func addItemToInventory(itemName:String):
	inventoryState[itemName] += 1
	inventoryState["TOTAL"] += 1

func removeItemFromInventory(itemName:String):
	inventoryState[itemName] -= 1
	inventoryState["TOTAL"] -= 1
	if(inventoryState["TOTAL"] == 0):
		$PlayerInventory.visible = false;
		
func createItemIconAndNumberAsset(itemName):
	var texture_display = TextureRect.new()
	texture_display.name = itemName
	texture_display.texture = assets[itemName]
	texture_display.z_index = 5
	texture_display.scale = Vector2(0.7, 0.7)
	# WHY CANT I RESIZE SHIT?!?!?!?!
	#texture_display.mouse_entered.connect(_on_mouse_entered)
	#texture_display.mouse_exited.connect(_on_mouse_exited)
	inventoryContainer.add_child(texture_display)
	
func updateItemNumberValue(itemName):
	print(itemName)
	
func _ready() -> void:
	onInit()

func onInit():
	assets.BEER = preload("res://assets/items/beer.png")
	assets.ICECREAM = preload("res://assets/items/icecream.png")
	assets.PUNCH = preload("res://assets/items/Punch.png")
	assets.RUTABAGA = preload("res://assets/items/Rudabega.png")
	assets.TACO = preload("res://assets/items/taco.png")
	assets.HOLYGRAIL = preload("res://assets/items/HolyGrail.png")
	assets.GUY =  preload("res://assets/items/guy.png")

#func _on_mouse_entered():
	#if tween: tween.kill()
	#tween = create_tween().set_parallel(true)
	## Bounce: Scale up slightly
	#tween.tween_property(item_icon, "scale", Vector2(1.2, 1.2), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	## Halo: Fade in
	#tween.tween_property(halo, "modulate:a", 1.0, 0.1)
#
#func _on_mouse_exited():
	#if tween: tween.kill()
	#tween = create_tween().set_parallel(true)
	## Scale back
	#tween.tween_property(item_icon, "scale", Vector2(1.0, 1.0), 0.15).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	## Halo: Fade out
	#tween.tween_property(halo, "modulate:a", 0.0, 0.1)
