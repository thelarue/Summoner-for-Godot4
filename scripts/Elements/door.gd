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
	#tween.set_ease( Tween.EASE_IN )
	#tween.set_trans( Tween.TRANS_EXPO )
	tween.tween_property( fade_mask, "modulate", Color.WHITE, 0.5 )
	tween.tween_property( fade_mask, "modulate", Color.WHITE, 0.2 )
	tween.finished.connect( screen_is_dark )


func screen_is_dark():
	var fade_mask = get_viewport().get_camera_2d().find_child("FadeMask")
	player.global_position = $DropPoint.global_position
	var tween  : Tween    = create_tween()
	tween.set_ease( Tween.EASE_IN )
	tween.set_trans( Tween.TRANS_EXPO )
	tween.tween_property( fade_mask, "modulate", Color.TRANSPARENT, 0.5 )
	tween.finished.connect( tween_finished )


func tween_finished():
	player.set_can_move(true)


