extends Node2D

@export var proximity_tought : String = "Nice."

@onready var door = $Door

var player_in_range : bool = false

func _ready():
	#InventoryManager.item_used.connect( item_used )
	if PuzzleCompletionList.puzzles["silver_door"]:
		set_can_pass()
	else:
		door.can_change_scene = false


func _process(_delta):
	player_in_range = false
	var bodies = %PlayerProximityArea.get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("player"):
			player_in_range = true



func is_player_in_range() -> bool:
	return player_in_range


func set_can_pass():
	door.can_change_scene = true
	$Sprite.texture.region.position.x = $Sprite.texture.region.size.x


func item_used( item ):
	if not player_in_range : return
	if item["method"] != "silver_key"  : return
	PuzzleCompletionList.puzzles["silver_door"] = true
	InventoryManager.remove_item( item["name"] )
	set_can_pass()


func _on_player_proximity_area_body_entered(body):
	if door.can_change_scene : return
	if body is Player:
		body.show_thought( proximity_tought )
