extends Node


var recipes = {
	["Fungi", "Horn"] : load("res://scenes/utils/test_summon.tscn")
}

func get_recipe_result(item1_name, item2_name):
	var recipe_key = [item1_name, item2_name]
	if recipe_key in recipes:
		return recipes[recipe_key]
	recipe_key = [item2_name, item1_name]
	if recipe_key in recipes:
		return recipes[recipe_key]
	return null
