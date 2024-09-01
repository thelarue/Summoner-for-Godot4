extends Sprite2D

@onready var player_node = get_tree().get_first_node_in_group("player")

@export var loot : PackedStringArray = []

var opened = false


func _on_actionable_actioned():
	if not opened: 
		for item in loot :
			Global.player_node.add_item( item )
	%Actionable.monitoring = false

func set_opened(b):
	opened = b
