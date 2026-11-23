extends Node2D

var tween: Tween

var assets = {
	"BEER": preload("res://shared/assets/items/beer.png"), 
	"ICECREAM": preload("res://shared/assets/items/icecream.png"), 
	"PUNCH": preload("res://shared/assets/items/Punch.png"), 
	"RUTABAGA": preload("res://shared/assets/items/Rudabega.png"), 
	"TACO": preload("res://shared/assets/items/taco.png"), 
	"HOLYGRAIL": preload("res://shared/assets/items/HolyGrail.png"), 
	"GUY": preload("res://shared/assets/items/GUY.png"), 
	"COFFEE": preload("res://shared/assets/items/StorBunksCoffee.png"),
	"RedSquare": preload("res://shared/assets/redSquareForNoReason.png")
	}
var inventoryState = {"BEER":0, "ICECREAM":0, "PUNCH":0, "RUTABAGA":0, "TACO":0, "HOLYGRAIL":0, "GUY": 0, "COFFEE":0, "TOTAL": 0, "RedSquare":0}

@onready var inventoryContainer = $ScrollContainer/Inventory;

func updateInventory(addOrRemove: String, itemName: String):
	if(addOrRemove == "add"):
		if(inventoryState[itemName] == 0):
			addItemToInventory(itemName)
			createItemIconAndNumberAsset(itemName)
		else:
			addItemToInventory(itemName)
			updateItemNumberValue(itemName)
	elif(addOrRemove=="remove"):
		if(inventoryState[itemName] == 0):
			removeItemFromInventory(itemName)
			createItemIconAndNumberAsset(itemName)
		else:
			removeItemFromInventory(itemName)
			updateItemNumberValue(itemName)
		
func addItemToInventory(itemName:String):
	inventoryState[itemName] += 1
	inventoryState["TOTAL"] += 1

func removeItemFromInventory(itemName:String):
	inventoryState[itemName] -= 1
	inventoryState["TOTAL"] -= 1
	if(inventoryState["TOTAL"] == 0):
		$PlayerInventory.visible = false;
		
func createItemIconAndNumberAsset(itemName: String):
	var item_panel = PanelContainer.new()
	item_panel.name = itemName + "Button"
	item_panel.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	item_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	item_panel.custom_minimum_size = Vector2(140, 72)

	var style = StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0) 
	item_panel.add_theme_stylebox_override("panel", style)

	var row = HBoxContainer.new()
	row.name = "Row"
	row.mouse_filter = Control.MOUSE_FILTER_IGNORE
	row.add_theme_constant_override("separation", 10)
	item_panel.add_child(row)

	var texture_display = TextureRect.new()
	texture_display.z_index = 5
	texture_display.name = itemName
	texture_display.texture = assets[itemName]
	texture_display.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture_display.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture_display.custom_minimum_size = Vector2(64, 64)
	texture_display.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var shader = Shader.new()
	shader.code = """
	shader_type canvas_item;

	uniform vec4 halo_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
	uniform float halo_width : hint_range(0.0, 0.15) = 0.0;

	void fragment() {
		float pad = 0.08;
		vec2 padded_uv = (UV - vec2(pad)) / (1.0 - 2.0 * pad);
		
		vec4 tex = vec4(0.0);
		if (padded_uv.x >= 0.0 && padded_uv.x <= 1.0 && padded_uv.y >= 0.0 && padded_uv.y <= 1.0) {
			tex = texture(TEXTURE, padded_uv);
		}
		
		float outline = 0.0;
		for (int i = 0; i < 16; i++) {
			float angle = float(i) * 0.39269908;
			vec2 sample_uv = padded_uv + vec2(cos(angle), sin(angle)) * halo_width;
			if (sample_uv.x >= 0.0 && sample_uv.x <= 1.0 && sample_uv.y >= 0.0 && sample_uv.y <= 1.0) {
				outline = max(outline, texture(TEXTURE, sample_uv).a);
			}
		}
		
		vec4 halo = vec4(halo_color.rgb, halo_color.a * outline);
		COLOR = mix(halo, tex, tex.a);
	}
	"""

	var mat = ShaderMaterial.new()
	mat.shader = shader
	mat.set_shader_parameter("halo_color", Color.WHITE)
	mat.set_shader_parameter("halo_width", 0.0)
	texture_display.material = mat

	row.add_child(texture_display)

	if itemName != "HOLYGRAIL":
		var label = Label.new()
		label.name = itemName + "label"
		label.z_index = 5
		label.text = "x 1"
		label.add_theme_font_size_override("font_size", 30)
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		label.mouse_filter = Control.MOUSE_FILTER_IGNORE
		row.add_child(label)
	else:
		var rectangle = ColorRect.new()
		rectangle.z_index = 5
		rectangle.color = Color("#504545")
		rectangle.custom_minimum_size = Vector2(64, 64)
		rectangle.mouse_filter = Control.MOUSE_FILTER_IGNORE
		row.add_child(rectangle)

	item_panel.mouse_entered.connect(_on_item_mouse_entered.bind(item_panel))
	item_panel.mouse_exited.connect(_on_item_mouse_exited.bind(item_panel))
	item_panel.gui_input.connect(_on_item_clicked.bind(itemName))

	inventoryContainer.add_child(item_panel)


func updateItemNumberValue(itemName):
	var path = "%sButton/Row/%slabel" % [itemName, itemName]
	var node = inventoryContainer.get_node_or_null(path)
	if node:
		node.text = "x %s" % str(inventoryState[itemName])
	if node:
		node.text='x %s' % [str(inventoryState[itemName])]
		
		
func _on_item_clicked(event: InputEvent, itemName: String):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Clicked item: ", itemName)

	
func _on_item_mouse_entered(item_panel: Control):
	var sprite = item_panel.get_node("Row").get_child(0)
	var hover_tween = create_tween().set_parallel(true)
	hover_tween.tween_property(sprite.material, "shader_parameter/halo_width", 0.06, 0.12)
	hover_tween.tween_property(sprite, "modulate", Color(1.15, 1.15, 1.15, 1.0), 0.12)

func _on_item_mouse_exited(item_panel: Control):
	var sprite = item_panel.get_node("Row").get_child(0)
	var exit_tween = create_tween().set_parallel(true)
	exit_tween.tween_property(sprite.material, "shader_parameter/halo_width", 0.0, 0.12)
	exit_tween.tween_property(sprite, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.12)
