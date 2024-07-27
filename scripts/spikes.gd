extends StaticBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		animated_sprite_2d.play("default")
		body.hit(1)
