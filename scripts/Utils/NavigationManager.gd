extends Node

const LEVELS : Dictionary = {
	"start"                : preload("res://scenes/starting_area/start.tscn"),
	"second_area"          : preload("res://scenes/starting_area/second_area.tscn"),
	"starting_room"        : preload("res://scenes/level 1/starting_room.tscn"),
	"hallway_1"            : preload("res://scenes/level 1/hallway_1.tscn"),
	"hallway_2"            : preload("res://scenes/level 1/hallway_2.tscn"),
	"hallway_3"            : preload("res://scenes/level 1/hallway_3.tscn"),
	"storage_room_1"       : preload("res://scenes/level 1/storage_room_1.tscn"),
	"southern_hallway"     : preload("res://scenes/level 1/southern_hallway.tscn"),
	"toilets"              : preload("res://scenes/level 1/toilets.tscn"),
	"livestock_room"       : preload("res://scenes/level 1/livestock_room.tscn")
}




signal on_trigger_player_spawn

var spawn_door_tag 

func go_to_level(level_tag, destination_tag):
	if not LEVELS.keys().has( level_tag ): assert( "Unkown target level" )
	
	var scene_to_load = LEVELS[level_tag]
	spawn_door_tag = destination_tag
	call_deferred("change_scene", scene_to_load)

func change_scene(scene_to_load):
	get_tree().change_scene_to_packed(scene_to_load)
	
func trigger_player_spawn(position : Vector2, direction : String):
	on_trigger_player_spawn.emit(position, direction)
