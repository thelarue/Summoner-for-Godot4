extends Node

var item_scene_path = "res://scenes/Inventory/inventory_item.tscn"

var recipes = {
	["Fungi", "Horn"]: {
		"name": "Health Potion",
		"type": "Potion",
		"quantity" : 1,
		"texture": load("res://assets/[32]-Iconset-Starter_Pack_01.png"),
		"effect": "+ 1 Heart",
		"value": 1,
		"method": "health_potion",
		"scene_path" : item_scene_path
	}
}

func get_recipe_result(item1_name, item2_name):
	var recipe_key = [item1_name, item2_name]
	if recipe_key in recipes:
		return recipes[recipe_key]
	recipe_key = [item2_name, item1_name]
	if recipe_key in recipes:
		return recipes[recipe_key]
	return null



