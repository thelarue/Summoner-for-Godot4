extends Node

var item_scene_path = "res://scenes/Inventory/inventory_item.tscn"

var recipes = {
	["White Phosphorus", "Black Herb"] : {
		"name" : "Alchemic Fire",
		"type" : "Battle, Summon Ingredient",
		"quantity" : 1,
		"effect" : "In Battle, thrown to deal damage to enemy\nUsed to summon Cal.",
		"texture" : load("res://assets/alchemic_fire.png"),
		"value" : 1,
		"consumable" : true,
		"method" : "use_ingredient",
		"scene_path" : item_scene_path
	},
 	["Red Herb", "Wild Berry"]: {
		"name": "Red Potion",
		"type": "Battle, Overworld",
		"quantity" : 1,
		"texture": load("res://assets/[32]-Iconset-Starter_Pack_01.png"),
		"effect": "Used to heal self",
		"value": 1,
		"consumable" : true,
		"method": "heal",
		"scene_path" : item_scene_path
	},
	["Monster Horn", "Blue Herb"] : {
		"name" : "Blue Potion",
		"type" : "Battle, Overworld",
		"quantity" : 1,
		"effect" : "Restore mana",
		"texture" : load("res://assets/[32]-Iconset-Starter_Pack_07.png"),
		"value" : 1,
		"consumable" : true,
		"method" : "mana_potion",
		"scene_path" : item_scene_path
	},
	["Red Herb", "Black Herb"] : {
		"name" : "Sleeping Powder",
		"type" : "Battle, Overworld",
		"quantity" : 1,
		"effect" : "Has a chance to sleep the enemy",
		"texture" : load("res://assets/32-Iconset-Starter_Pack_219.png"),
		"value" : 1,
		"consumable" : true,
		"method" : "sleeping_powder",
		"scene_path" : item_scene_path
	},
}

func get_recipe_result(item1_name, item2_name):
	var recipe_key = [item1_name, item2_name]
	if recipe_key in recipes:
		return recipes[recipe_key]
	recipe_key = [item2_name, item1_name]
	if recipe_key in recipes:
		return recipes[recipe_key]
	return null



