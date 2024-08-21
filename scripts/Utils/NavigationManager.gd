extends Node

const LEVELS : Dictionary = {
	"start"                : preload("res://scenes/starting_area/start.tscn"),
	"second_area"          : preload("res://scenes/starting_area/second_area.tscn")
}


signal on_trigger_player_spawn

var spawn_door_tag 

func go_to_level(level_tag, destination_tag):
	assert( LEVELS.keys().has( level_tag ), "Unkown target level" )
	
	var scene_to_load = LEVELS[level_tag]
	spawn_door_tag = destination_tag
	call_deferred("change_scene", scene_to_load)

func change_scene(scene_to_load):
	get_tree().change_scene_to_packed(scene_to_load)
	
func trigger_player_spawn(position : Vector2, direction : String):
	on_trigger_player_spawn.emit(position, direction)
