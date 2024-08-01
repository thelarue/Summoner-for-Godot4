extends Area2D

class_name Door

@export var destionation_level_tag : String
@export var destination_door_tag : String
@export var spawn_direction = "up"

@onready var spawn = $Spawn

var can_change_scene = true

func _on_body_entered(body):
	if body.is_in_group("player") and can_change_scene:
		NavigationManager.go_to_level(destionation_level_tag, destination_door_tag)

func set_can_change_scene(b):
	can_change_scene = b

