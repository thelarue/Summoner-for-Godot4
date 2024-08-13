extends Room

func _ready():
	if NavigationManager.spawn_door_tag:
		_on_level_spawn(NavigationManager.spawn_door_tag)
