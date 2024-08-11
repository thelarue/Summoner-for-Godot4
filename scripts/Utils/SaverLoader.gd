extends Node

var player_inventory = []
var player_creatures : Array[PackedScene]
var player_health : int
var player_mana : int
var picked_up_items : Dictionary
var player_save_position : Vector2

func set_data():
	player_inventory = InventoryManager.inventory
	player_creatures = SummonInventory.summons
	player_health = Global.player_health
	picked_up_items = Global.picked_up_items
	player_save_position = Global.player_save_position
	player_mana = Global.player_mana

func save():
	set_data()
	var creature_paths = []
	for creature in player_creatures:
		if creature != null:
			creature_paths.append(creature.resource_path)

	var inventory_data = []
	for item in player_inventory:
		if item:
			inventory_data.append({
				"quantity" : item["quantity"],
				"type" : item["type"],
				"name" : item["name"],
				"texture" : item["texture"].resource_path,
				"effect" : item["effect"],
				"method" : item["method"],
				"value" : item["value"],
				"scene_path" : item["scene_path"],
				"consumable" : item["consumable"]
			})
	
	var data = {
		"player_inventory" : inventory_data,
		"player_creatures" : creature_paths,
		"player_health" : player_health,
		"player_mana" : player_mana,
		"picked_up_items" : picked_up_items,
		"player_save_position" : player_save_position,
	}
	return data


func save_game():
	var data = save()
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_file.store_var(data)
	save_file.close()

func load_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	if save_file:
		var data = save_file.get_var()
		save_file.close()
		load_data(data)
	else:
		print("No save file found!")

func load_data(data):
	Global.player_health = data["player_health"]
	Global.player_mana = data["player_mana"]
	Global.picked_up_items = data["picked_up_items"]
	Global.player_save_position = data["player_save_position"]
	
	
	var inventory_data = []
	for item_data in data["player_inventory"]:
		if item_data:
			var item = {
				"quantity" : item_data["quantity"],
				"type" : item_data["type"],
				"name" : item_data["name"],
				"texture" : load(item_data["texture"]),
				"effect" : item_data["effect"],
				"method" : item_data["method"],
				"value" : item_data["value"],
				"scene_path" : item_data["scene_path"]
			}
			inventory_data.append(item)
		
	InventoryManager.inventory = inventory_data
	InventoryManager.inventory.resize(6)
	var creatures = []
	for packed_scene_path in data["player_creatures"]:
		var packed_scene = ResourceLoader.load(packed_scene_path)
		if packed_scene:
			creatures.append(packed_scene)
	
	SummonInventory.summons.clear()
	for creature in creatures:
		SummonInventory.summons.append(creature)

	SummonInventory.summons.resize(3)
	InventoryManager.inventory_updated.emit()
	SummonInventory.team_updated.emit()
