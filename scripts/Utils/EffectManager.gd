extends Node


var player_node : Node = null

var alchemy_menu : Control = null

var summoning_menu : Node = null

func set_summoning_menu(menu):
	summoning_menu = menu

func set_alchemy_menu(menu):
	alchemy_menu = menu
	
func set_player_reference(player):
	player_node = player
	
func health_potion(item):
	player_node.add_health(item["value"])
	return true
	
func use_ingredient(item):
	alchemy_menu.add_ingredient(item)
	return true

func use_summon_ingredient(item):
	if player_node != null and summoning_menu.visible == true:
		summoning_menu.add_summon_ingredient(item)
		return true
