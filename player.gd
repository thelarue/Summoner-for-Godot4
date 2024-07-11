extends CharacterBody2D


var speed = 40

func player_movement():
	var move = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = move * speed

func _physics_process(delta):
	player_movement()
	move_and_slide()
