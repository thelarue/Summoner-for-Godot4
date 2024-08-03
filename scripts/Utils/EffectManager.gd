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
	
func heal(item):
	if Global.player_health < player_node.max_health:
		player_node.add_health(item["value"])
		return true
	return false
	
func use_ingredient(item):
	if player_node:
		if (player_node.get_node("InventoryUI/AlchemyMenu").visible == true 
			and  player_node.get_node("InventoryUI/SummoningCircleUI").visible == false):	
			alchemy_menu.add_ingredient(item)
			return true
		elif (player_node.get_node("InventoryUI/AlchemyMenu").visible == false 
			and  player_node.get_node("InventoryUI/SummoningCircleUI").visible == true):
			summoning_menu.add_summon_ingredient(item)
			return true
	return false

func ritual_knife(item):
	if player_node:
		player_node.hit(item["value"])
	
