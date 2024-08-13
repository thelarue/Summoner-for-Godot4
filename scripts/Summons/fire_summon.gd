extends Summon

class_name FireSummon

@export var fireball_scene : PackedScene = null
var active_fireball : Area2D = null


func overworld_ability() -> void:
	if active_fireball == null:
		var player_node = Global.get_player_node()
		if player_node:
			if Global.player_mana >= mana_cost:
				var fireball = fireball_scene.instantiate()
				fireball.connect("fireball_removed", _on_fireball_removed)
				
				fireball.set_position(global_position)  # Start from the character's position
				fireball.set_direction(player_node.get_direction())  # Set the direction of the fireball

				player_node.add_child(fireball)
				active_fireball = fireball
				Global.player_mana -= mana_cost
	
func _on_fireball_removed():
	active_fireball = null
