extends Node2D

@onready var items = $Items

func _ready():
	if NavigationManager.spawn_door_tag:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	
	setup_items()

func setup_items():
	for item in items.get_children():
		if Global.is_item_picked_up(item.item_id):
			item.set_opened(true)

func _on_level_spawn(destination_tag : String):
	var door_path = "Doors/BloodDoorPuzzle/Door"
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
