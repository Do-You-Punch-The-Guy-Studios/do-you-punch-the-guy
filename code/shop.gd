extends Node2D
var tween: Tween

var assets = {"BEER":{}, "ICECREAM":{}, "PUNCH":{}, "RUTABAGA":{}, "TACO":{}, "HOLYGRAIL":{}, "GUY":{}}
var inventoryState = {"BEER":0, "ICECREAM":0, "PUNCH":0, "RUTABAGA":0, "TACO":0, "HOLYGRAIL":0, "GUY": 0, "TOTAL": 0}

@onready var inventoryContainer = $ShopItemsContainer/ItemsForSale;

func stockItems(shopInventory):
	for item in shopInventory:
		createItemIconAndNumberAsset(item.item, item.quantity)
		addItemToInventory(item.item)
		updateItemNumberValue(item.quantity)
		
func addItemToInventory(itemName:String):
	inventoryState[itemName] += 1
	inventoryState["TOTAL"] += 1

func removeItemFromInventory(itemName:String):
	inventoryState[itemName] -= 1
	inventoryState["TOTAL"] -= 1
	if(inventoryState["TOTAL"] == 0):
		$TheShop.visible = false;
		
func createItemIconAndNumberAsset(itemName, quantity):
	var texture_display = TextureRect.new()
	if(itemName != "HOLYGRAIL"):
		var label = Label.new();
		label.name = itemName + 'label'
		inventoryState[itemName] = quantity
		label.text = 'x ' + str(int(inventoryState[itemName]))
		label.scale = Vector2(3, 3)
		label.position = Vector2(100, 10)
		label.z_index = 5
		texture_display.add_child(label)
	
	texture_display.name = itemName
	texture_display.texture = assets[itemName]
	texture_display.z_index = 5
	texture_display.scale = Vector2(0.7, 0.7)
	texture_display.position = Vector2(0, 500)
	# WHY CANT I RESIZE SHIT?!?!?!?!
	#texture_display.mouse_entered.connect(_on_mouse_entered)
	#texture_display.mouse_exited.connect(_on_mouse_exited)
	inventoryContainer.add_child(texture_display)
	
func updateItemNumberValue(itemName):
	var path = "ScrollContainer/Inventory/%s/%slabel" % [itemName, itemName]
	var node = get_node_or_null(path)	
	if node:
		node.text='x ' + str(inventoryState[itemName])
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
