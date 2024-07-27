extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@export var SPEED : float = 100.0
@export var dmg : int  = 2
@onready var anim = $AnimatedSprite2D

func _physics_process(_delta):
	if player != null:
		var direction = global_position.direction_to(player.global_position)	
		velocity = SPEED * direction
	var collisions = get_slide_collision_count()
	for i in collisions:
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("player"):
			collider.hit(dmg)
	handle_animations()
	move_and_slide()

func handle_animations():
	if velocity.length() == 0:
		if anim.is_playing():
			anim.stop()
	else:
		var dir = "down"
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x < 0: 
				dir = "left"
			elif velocity.x > 0: 
				dir = "right"
		else:
			if velocity.y < 0: 
				dir = "up"
			elif velocity.y > 0: 
				dir = "down"
		
		anim.play("walk_" + dir)
	
