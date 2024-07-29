extends Node


var player_node : Node = null

var alchemy_menu : Control = null

func set_alchemy_menu(menu):
	alchemy_menu = menu
	
func set_player_reference(player):
	player_node = player
	
func health_potion(item):
	player_node.add_health(item["value"])
	
func use_ingredient(item):
	alchemy_menu.add_ingredient(item)
