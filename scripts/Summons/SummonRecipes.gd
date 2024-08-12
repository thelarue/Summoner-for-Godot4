extends Node


var recipes = {
	["Eyeball", "Alchemic Fire", "Beast Fur"] : load("res://scenes/Summons/fire_summon.tscn"),
	["Eyeball", "Sleeping rabbit", "Rainbow quartz"] : load("res://scenes/Summons/celestial_summon.tscn"),
	["Eyeball", "Mandrake Root", "Snake Tangle"] : load("res://scenes/Summons/nature_summon.tscn")
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
