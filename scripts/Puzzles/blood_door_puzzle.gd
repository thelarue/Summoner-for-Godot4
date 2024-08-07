extends Node2D

@onready var door = $Door
@onready var open_door = $OpenDoor
@onready var closed_door = $ClosedDoor

var player_in_range : bool = false

func _ready():
	EffectManager.set_blood_door_puzzle(self)
	door.set_can_change_scene(false)

func is_player_in_range() -> bool:
	return player_in_range

func set_can_pass():
	door.set_can_change_scene(true)
	closed_door.visible = false
	open_door.visible = true


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
