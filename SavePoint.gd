extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")

func _on_actionable_actioned():
	Global.player_save_position = player.global_position
	SaverLoader.save_game()
