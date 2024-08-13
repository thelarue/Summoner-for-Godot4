extends Room

@onready var items = $Items

func _ready():
	if NavigationManager.spawn_door_tag:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	
	set_up_items()

func set_up_items():
	for item in items.get_children():
		if item and Global.is_item_picked_up(item.item_id):
			item.set_opened(true)
