extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#Dialogic.start("res://dialogues/debug room/intro.dtl")
	RenderingServer.set_default_clear_color( Color.BLACK )
	%Environment.visible = true
	pass


func _on_toilets_actioned():
	var fade_mask = get_viewport().get_camera_2d().find_child("FadeMask")
	var tween  : Tween    = create_tween()
	#tween.set_ease( Tween.EASE_IN )
	#tween.set_trans( Tween.TRANS_EXPO )
	tween.tween_property( fade_mask, "modulate", Color.WHITE, 0.5 )
	tween.tween_property( fade_mask, "modulate", Color.WHITE, 0.2 )
	tween.finished.connect( toilet_scene_dark )


func toilet_scene_dark():
	%player.show_thought( "oooh noo! gross! What was I expecting? a secret room maybe?" )
