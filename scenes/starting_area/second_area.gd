extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_interaction_area_body_entered(body):
	call_deferred("change_room")

func change_room():
	get_tree().change_scene_to_file("res://scenes/starting_area/start.tscn")
