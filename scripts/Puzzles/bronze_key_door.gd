extends Node2D

@onready var door = $Door

var player_in_range : bool = false

func _ready():
	InventoryManager.item_used.connect( item_used )
	if PuzzleCompletionList.puzzles["bronze_door"]:
		set_can_pass()
	else:
		door.can_change_scene = false


func _process(_delta):
	player_in_range = false
	var bodies = %PlayerProximityArea.get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("player"):
			player_in_range = true
	
	%Puzzle.visible = player_in_range and not door.can_change_scene



func is_player_in_range() -> bool:
	return player_in_range


func set_can_pass():
	door.can_change_scene = true
	$Sprite.texture.region.position.x = $Sprite.texture.region.size.x


func item_used( item ):
	if not player_in_range : return
	if item["method"] != "bronze_key"  : return
	PuzzleCompletionList.puzzles["bronze_door"] = true
	set_can_pass()
