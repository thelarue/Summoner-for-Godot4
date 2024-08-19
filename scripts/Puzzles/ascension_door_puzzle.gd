extends Node2D

@export var proximity_tought : String = "Nice."

@onready var door = $Door
@onready var open_door = $OpenDoor
@onready var closed_door = $ClosedDoor

var player_in_range : bool = false

func _ready():
	if PuzzleCompletionList.puzzles["ascension_door"]:
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
	closed_door.visible = false
	open_door.visible = true


func _on_player_proximity_area_body_entered(body):
	if door.can_change_scene : return
	if body is Player:
		if PuzzleCompletionList.puzzles["ascension_password"]:
			body.show_thought( "banana" )
			$OpenTimer.start()
		else:
			body.show_thought( proximity_tought )


func _on_open_timer_timeout():
	PuzzleCompletionList.puzzles["ascension_door"] = true
	set_can_pass()
