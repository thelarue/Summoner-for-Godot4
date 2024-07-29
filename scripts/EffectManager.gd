extends Node


var player_node : Node = null

func set_player_reference(player):
	player_node = player
	
func health_potion(health_amount):
	player_node.add_health(health_amount)
	
