extends CharacterBody2D

class_name FireSummon

var summon_name : String = "Cal"
var type : String  = "Fire"
var health : int = 10
@export var mana_cost : int = 1

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

func get_creature_name() -> String:
	return summon_name

func get_creature_type() -> String:
	return type

func get_creature_health() -> int:
	return health
	
func _on_fireball_removed():
	active_fireball = null
