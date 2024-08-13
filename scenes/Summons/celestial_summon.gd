extends Summon

class_name CelestialSummon

var spirit_world = false

func overworld_ability():
	var player_node = Global.player_node
	if player_node:
		if spirit_world == false:
			var fog = player_node.get_node("Camera2D/CanvasLayer/ParallaxBackground")
			if fog:
				fog.visible = true
			var player_current_scene = player_node.get_tree().current_scene
			var spirits = player_current_scene.get_node("Spirits")
			if spirits:
				for spirit in spirits.get_children():
					if spirit:
						spirit.visible = true
						spirit.set_disabled(false)
				Global.player_mana -= mana_cost
				spirit_world = true
		else:
			spirit_world = false
			var fog = player_node.get_node("Camera2D/CanvasLayer/ParallaxBackground")
			if fog:
				fog.visible = false
			var player_current_scene = player_node.get_tree().current_scene
			var spirits = player_current_scene.get_node("Spirits")
			if spirits:
				for spirit in spirits.get_children():
					if spirit:
						spirit.visible = false
						spirit.set_disabled(true)
