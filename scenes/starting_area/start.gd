extends Node2D

@onready var switch = $interactives/Switch
@onready var door = $Doors/Door_S

var can_pass = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Dialogic.start("res://dialogues/debug room/intro.dtl")
	AudioPlayer.play_music_level()
	
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	
	door.set_can_change_scene(false)
	
	for item in $Items.get_children():
		
		if Global.is_item_picked_up(item.item_id):
			item.set_opened(true)
	
	if true:
		pass

func _on_level_spawn(destination_tag : String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_door_puzzle()
	pass

func _door_puzzle():
	if switch != null:
		if switch.frame == 1:
			door.get_node("Sprite2D").frame = 0
		if switch.frame == 2:
			door.get_node("Sprite2D").frame = 1
			door.set_can_change_scene(true)
	

