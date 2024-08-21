extends Sprite2D

@export var item_id = ""

@export var item_type : String = ""
@export var item_method : String = ""
@export var item_name : String = ""
@export var item_texture : Texture
@export var item_effect : String = ""
@export var effect_value : int = 0
@export var consumable : bool = true

@export var recipe : Array[Item] = []

var scene_path : String = "res://scenes/Inventory/inventory_item.tscn"

@onready var player_node = get_tree().get_first_node_in_group("player")
var opened = false

func pickup_item():
	var item = {
		"quantity" : 1,
		"type" : item_type,
		"name" : item_name,
		"texture" : item_texture,
		"effect" : item_effect,
		"method" : item_method,
		"consumable" : consumable,
		"value" : effect_value,
 		"scene_path" : scene_path
	}
	if InventoryManager.player_node:
		if InventoryManager.add_item(item):
			if player_node:
				player_node.add_item( item )
			Global.add_picked_up_item(item_id)
			opened = true
		else:
			print(InventoryManager.current_inventory_size())
	texture.region.position.x = texture.region.size.x


func set_item_data(data):
	item_type = data["type"]
	item_name = data["name"]
	item_effect = data["effect"]
	item_texture = data["texture"]
	effect_value = data["value"]
	item_method = data["method"]
	consumable = data["consumable"]

func _on_actionable_actioned():
	if not opened: 
		pickup_item()
	%Actionable.monitoring = false

func set_opened(b):
	opened = b
