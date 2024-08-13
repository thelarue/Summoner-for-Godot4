extends Node

var player_health : int = 6
var player_mana : int = 3

var player_node : Node = null

var picked_up_items : Dictionary = {}

var player_save_position : Vector2

func add_picked_up_item(item_id):
	picked_up_items[item_id] = true

func is_item_picked_up(item_id):
	return picked_up_items.has(item_id)

func remove_picked_up_item(item_id):
	picked_up_items.erase(item_id)

func get_player_node():
	return player_node

func set_player_node(player):
	player_node = player


