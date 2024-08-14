extends Area2D

class_name Door

@export var destination_level_tag : String
@export var destination_door_tag : String
@onready var player = get_tree().get_first_node_in_group("player")

var can_change_scene = true

func _process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("player") and can_change_scene:
			change_room()

func change_room():
	if player:
		player.set_can_move(false)
	var fade_mask = get_viewport().get_camera_2d().find_child("FadeMask")
	var tween  : Tween    = create_tween()
	tween.tween_property( fade_mask, "modulate", Color.WHITE, 1 )
	tween.finished.connect( tween_finished )

func tween_finished():
	NavigationManager.go_to_level( destination_level_tag, destination_door_tag )

