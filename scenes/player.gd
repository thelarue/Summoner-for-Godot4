extends CharacterBody2D


const SPEED = 50.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var move_x = Input.get_axis("ui_left", "ui_right")
	var move_y = Input.get_axis("ui_up", "ui_down") 
	if move_x:
		velocity.x = move_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if move_y:
		velocity.y = move_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
