extends CharacterBody2D

@export var stats : Resource

@export var fireball_scene : PackedScene = null
var active_fireball : Area2D = null

func _ready():
	if stats:
		stats.name = "Cal"
		stats.type = "Fire"
		stats.health = 10

func overworld_ability():
	if active_fireball == null:
		var fireball = fireball_scene.instantiate()
		fireball.connect("fireball_removed", _on_fireball_removed)
		var direction = Vector2.RIGHT  # Replace with the desired direction, e.g., towards the right
		
		
		fireball.set_position(global_position)  # Start from the character's position
		fireball.set_direction(Global.get_player_node().get_direction())  # Set the direction of the fireball

		Global.get_player_node().add_child(fireball)
		active_fireball = fireball


func _on_fireball_removed():
	active_fireball = null
