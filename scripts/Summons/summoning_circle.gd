extends Node2D


var player = null
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player.get_node("InventoryUI").visible = false
		player.get_node("InventoryUI/AlchemyMenu").visible = true
		player.get_node("InventoryUI/SummoningCircleUI").get_items_back()
		player.get_node("InventoryUI/SummoningCircleUI").clear_slots()
		player.get_node("InventoryUI/SummoningCircleUI").visible = false
		player.set_can_open_inventory(true)

func _on_actionable_actioned():
	if player != null:
		player.get_node("InventoryUI").visible = true
		player.get_node("InventoryUI/AlchemyMenu").visible = false
		player.get_node("InventoryUI/SummoningCircleUI").visible = true
		player.set_can_open_inventory(false)


		
