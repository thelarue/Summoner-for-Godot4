extends CharacterBody2D


var speed = 60
@onready var anim = $AnimationPlayer


func player_movement():
	var move = Input.get_vector("left", "right", "up", "down")
	velocity = move * speed

func update_anim():
	if velocity.length() == 0:
		if anim.is_playing():
			anim.stop()
	else:
		var dir = "down"
		if velocity.x < 0: dir = "left"
		elif velocity.x> 0: dir = "right"
		elif velocity.y < 0: dir = "up"
		
		anim.play("walk_" + dir)

func _physics_process(delta):
	player_movement()
	move_and_slide()
	update_anim()
	pass

func _process(delta):
	pass
