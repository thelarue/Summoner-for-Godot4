extends Room

@onready var items = $Items

func _ready():
	if NavigationManager.spawn_door_tag:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	
	
	AudioPlayer.play_music_level()
	
	setup_items()
	Dialogic.start("res://dialogues/debug room/intro.dtl")

func setup_items():
	for item in items.get_children():
		if Global.is_item_picked_up(item.item_id):
			item.set_opened(true)
