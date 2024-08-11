extends StaticBody2D

class_name Barrel
@onready var animated_sprite_2d = $AnimatedSprite2D

var destroyed = false

func destroy() -> void:
	if destroyed == false:
		animated_sprite_2d.play("destroy")
		destroyed = true
