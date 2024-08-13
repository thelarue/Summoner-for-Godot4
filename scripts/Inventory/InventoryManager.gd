extends Node

var inventory = []

signal inventory_updated
signal item_used( item )

var player_node : Node = null

var max_item_quantity = 3

@onready var inventory_slot = preload("res://scenes/Inventory/inventory_slot.tscn")

func _ready():
	inventory.resize(6)

func add_item(item):
	for i in range(inventory.size()):
		if (inventory[i] != null 
		and inventory[i]["name"] == item["name"]
		and inventory[i]["consumable"] == item["consumable"]
		and inventory[i]["type"] == item["type"] 
		and inventory[i]["effect"] == item["effect"]):
			if inventory[i]["quantity"] == 3:
				continue
			inventory[i]["quantity"] += item["quantity"]
			inventory_updated.emit()
			print("new item")
			return true
		elif inventory[i] == null:
			if item["quantity"] == 0:
				item["quantity"] = 1
			inventory[i] = item
			inventory_updated.emit()
			print("added item")
			return true
	return false

func remove_item(item_name):
	for i in range(inventory.size()):
		if (inventory[i] != null 
		and inventory[i]["name"] == item_name):
			inventory[i]["quantity"] -= 1
			if inventory[i]["quantity"] <= 0:
				inventory[i] = null
			inventory_updated.emit()
			return true
	return false

func current_inventory_size():
	var r = 0
	for i in range(inventory.size()):
		if inventory[i]:
			r += 1
	print(inventory.size())
	return r
	
func increase_inventory_size():
	inventory_updated.emit()

func set_player_reference(player):
	player_node = player

func adjust_drop_position(position):
	var radius = 35
	var nearby_items = get_tree().get_nodes_in_group("Items")
	for item in nearby_items:
		if item.global_position.distance_to(position) < radius:
			var random_offset =  Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
			position += random_offset
			break
	return position

func drop_item(item_data, drop_position):
	var item_scene = load(item_data["scene_path"])
	var item_instance = item_scene.instantiate()
	item_instance.set_item_data(item_data)
	item_instance.global_position = drop_position
	get_tree().current_scene.add_child(item_instance)
	return item_instance

func check_azure_flower():
	for item in inventory:
		if item != null and item["name"] == "Azure Flower":
			remove_item(item["name"])
			return true
	return false

func inventory_item_used( item ):
	item_used.emit( item )
