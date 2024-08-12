extends Summon


func overworld_ability():
	var player_node = Global.get_player_node()
	if player_node:
		var grass_area = player_node.get_closest_grass_area()
		if grass_area:
			grass_area.get_node("ColorRect").visible = true
			grass_area.get_node("StaticBody2D/CollisionShape2D").disabled = true
			Global.player_mana -= mana_cost
