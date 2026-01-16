extends Node2D

var itemsObject = {"BEER":{}, "ICECREAM":{}, "PUNCH":{}, "RUTABAGA":{}, "TACO":{}}


func _ready() -> void:
	onInit()

func onInit():
	itemsObject = {"BEER":{}, "ICECREAM":{}, "PUNCH":{}, "RUTABAGA":{}, "TACO":{}}
	itemsObject.BEER.sprite = $Beer
	itemsObject.BEER.quantity = 0
	itemsObject.BEER.quantityLabel = $Beer/BeerQuantity
	itemsObject.ICECREAM.sprite = $Icecream
	itemsObject.ICECREAM.quantityLabel = $Icecream/IceCreamQuantity
	itemsObject.ICECREAM.quantity = 0
	itemsObject.PUNCH.sprite = $Punch
	itemsObject.PUNCH.quantityLabel = $Punch/PunchQuantity
	itemsObject.PUNCH.quantity = 0
	itemsObject.RUTABAGA.sprite = $Rutabaga
	itemsObject.RUTABAGA.quantityLabel = $Rutabaga/RutabagaQuantity
	itemsObject.RUTABAGA.quantity = 0
	itemsObject.TACO.sprite = $Taco
	itemsObject.TACO.quantityLabel = $Taco/TacoQuantity
	itemsObject.TACO.quantity = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func displayInventory(playerInventory: Array):
	onInit()
	playerInventory.sort()
	for inventoryItem in playerInventory:
		itemsObject[inventoryItem].quantity += 1 
	print(itemsObject)
	for item in itemsObject:
		if(itemsObject[item].sprite.hidden && itemsObject[item].quantity > 0):
			itemsObject[item].sprite.show()
		if(itemsObject[item].quantityLabel.hidden && itemsObject[item].quantity > 1):
			itemsObject[item].quantityLabel.show()
			
		
