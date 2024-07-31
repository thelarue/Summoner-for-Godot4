extends Node


var recipes = {
	["Fungi", "Horn", "Health Potion"] : load("res://scenes/utils/test_summon.tscn")
}

func get_recipe_result(item1_name, item2_name, item3_name):
	var recipe_key = [item1_name, item2_name, item3_name]
	if recipe_key in recipes:
		return recipes[recipe_key]
	recipe_key = [item1_name, item3_name, item2_name]
	if recipe_key in recipes:
		return recipes[recipe_key]
	recipe_key = [item2_name, item1_name, item3_name]
	if recipe_key in recipes:
		return recipes[recipe_key]
	recipe_key = [item2_name, item3_name, item1_name]
	if recipe_key in recipes:
		return recipes[recipe_key]
	recipe_key = [item3_name, item1_name, item2_name]
	if recipe_key in recipes:
		return recipes[recipe_key]
	recipe_key = [item3_name, item2_name, item1_name]
	if recipe_key in recipes:
		return recipes[recipe_key]
	return null
