extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")

func _on_actionable_actioned():
	if InventoryManager.check_azure_flower():
		Global.player_save_position = player.global_position
		SaverLoader.save_game()
	else:
		#Show message to player
		print("No Azure Flower")
