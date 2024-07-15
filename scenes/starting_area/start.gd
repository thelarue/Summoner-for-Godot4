extends Node2D

@onready var switch = $interactives/Switch
@onready var door = $bg/southernDoor.get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_door_puzzle()
	pass
	

func _door_puzzle():
	if switch.frame == 1:
		door.frame = 0
	if switch.frame == 2:
		door.frame = 1
	

func _on_interaction_area_body_entered(body):
	if door.frame == 1:
		get_tree().change_scene_to_file("res://scenes/starting_area/second_area.tscn")
