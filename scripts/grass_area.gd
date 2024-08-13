extends Node2D

@onready var animated_sprite_2d : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d : CollisionShape2D = $StaticBody2D/CollisionShape2D


var active = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.set_closest_grass_area(self)

func grow(mana_cost : int):
	if not active:
		animated_sprite_2d.play("growth")
		collision_shape_2d.disabled = true
		active = true
		Global.player_mana -= mana_cost
