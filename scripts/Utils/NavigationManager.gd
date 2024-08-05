extends Node

const start = preload("res://scenes/starting_area/start.tscn")
const second_area = preload("res://scenes/starting_area/second_area.tscn")

signal on_trigger_player_spawn

var spawn_door_tag 

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	match level_tag:
		"start":
			scene_to_load = start
		"second_area":
			scene_to_load = second_area
		
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		call_deferred("change_scene", scene_to_load)

func change_scene(scene_to_load):
	get_tree().change_scene_to_packed(scene_to_load)
	
func trigger_player_spawn(position : Vector2, direction : String):
	on_trigger_player_spawn.emit(position, direction)
