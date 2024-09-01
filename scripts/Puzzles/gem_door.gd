extends Node2D

@onready var door = $Door

@export var proximity_tought : String = "Nice."
var player_in_range : bool = false

func _ready():
	#InventoryManager.item_used.connect( item_used )
	if (
		PuzzleCompletionList.puzzles["gem_door_red"] and 
		PuzzleCompletionList.puzzles["gem_door_blue"] and 
		PuzzleCompletionList.puzzles["gem_door_purple"] 
		):
		set_can_pass()
	else:
		door.can_change_scene = false


func _process(_delta):
	player_in_range = false
	var bodies = %PlayerProximityArea.get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("player"):
			player_in_range = true
	
	$Sprite.visible = not door.can_change_scene
	%RedGemOverlay.visible = PuzzleCompletionList.puzzles["gem_door_red"] and not door.can_change_scene
	%BlueGemOverlay.visible = PuzzleCompletionList.puzzles["gem_door_blue"] and not door.can_change_scene
	%PurpleGemOverlay.visible = PuzzleCompletionList.puzzles["gem_door_purple"] and not door.can_change_scene


func is_player_in_range() -> bool:
	return player_in_range


func set_can_pass():
	door.can_change_scene = true


func item_used( item ):
	if not player_in_range : return
	if item["method"] == "red_gem" : 
		PuzzleCompletionList.puzzles["gem_door_red"] = true
		InventoryManager.remove_item( item["name"] )
	if item["method"] == "blue_gem" : 
		PuzzleCompletionList.puzzles["gem_door_blue"] = true
		InventoryManager.remove_item( item["name"] )
	if item["method"] == "purple_gem" : 
		PuzzleCompletionList.puzzles["gem_door_purple"] = true
		InventoryManager.remove_item( item["name"] )
	if (
		PuzzleCompletionList.puzzles["gem_door_red"] and 
		PuzzleCompletionList.puzzles["gem_door_blue"] and 
		PuzzleCompletionList.puzzles["gem_door_purple"] 
		):
		set_can_pass()
	else:
		door.can_change_scene = false
