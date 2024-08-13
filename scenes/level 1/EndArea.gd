extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not has_overlapping_bodies() : return
	
	var fade_mask = get_viewport().get_camera_2d().find_child("FadeMask")
	var tween  : Tween    = create_tween()
	tween.tween_property( fade_mask, "modulate", Color.BLACK, 1 )
	tween.finished.connect(to_credits)


func to_credits():
	get_tree().change_scene_to_file( "res://scenes/Credits/Credits.tscn" )
