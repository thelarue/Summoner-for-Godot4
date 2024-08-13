extends Node

class_name Room


func _on_level_spawn(destination_tag : String):
	var drop_points = get_tree().get_nodes_in_group("gateway_drop_points")
	for drop_point in drop_points:
		if drop_point.door_tag == destination_tag :
			NavigationManager.trigger_player_spawn(drop_point.global_position, drop_point.spawn_direction)
			return
