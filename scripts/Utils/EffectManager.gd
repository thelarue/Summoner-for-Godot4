extends Node


var player_node : Node = null

var alchemy_menu : Control = null

var summoning_menu : Node = null

var blood_door_puzzle : Node = null


func set_summoning_menu(menu):
	summoning_menu = menu

func set_alchemy_menu(menu):
	alchemy_menu = menu
	
func set_player_reference(player):
	player_node = player

func set_blood_door_puzzle(door):
	blood_door_puzzle = door
	
func heal(item):
	if Global.player_health < player_node.max_health:
		player_node.add_health(item["value"])
		return true
	return false
	
func use_ingredient(item):
	if player_node:
		if (player_node.get_node("InventoryUI/AlchemyMenu").visible == true 
			and  player_node.get_node("InventoryUI/SummoningCircleUI").visible == false):	
			if alchemy_menu.add_ingredient(item):
				return true
			else: 
				return false
		elif (player_node.get_node("InventoryUI/AlchemyMenu").visible == false 
			and  player_node.get_node("InventoryUI/SummoningCircleUI").visible == true):
			if summoning_menu.add_summon_ingredient(item):
				return true
			else:
				return false
	return false

func ritual_knife(item):
	if player_node:
		player_node.hit(item["value"])
		if blood_door_puzzle:
			if blood_door_puzzle.is_player_in_range():
				blood_door_puzzle.set_can_pass()
		return true
	return false
	
func severed_hand(item):
	if player_node:
		var item_instance = InventoryManager.drop_item(item, player_node.global_position)
		var enemy_dog = get_tree().current_scene.get_node("EnemyDog")
		if enemy_dog == null : return false
		enemy_dog.change_target(item_instance)
		return true
	return false

func mana_potion(item):
	if Global.player_mana < player_node.max_mana:
		player_node.add_mana(item["value"])
		return true
	return false

func white_phosphorus(item):
	if player_node:
		if (player_node.get_node("InventoryUI/AlchemyMenu").visible == true 
			and  player_node.get_node("InventoryUI/SummoningCircleUI").visible == false):
				alchemy_menu.add_ingredient(item)
				return true
		else:
			player_node.hit(item["value"])
			return true
	return false

func sleeping_powder():
	pass
