extends CharacterBody2D

@export var target : Node2D = null

@export var SPEED : float = 100.0
@export var dmg : int  = 2
@onready var anim = $AnimatedSprite2D

@onready var navigation_agent_2d = $NavigationAgent2D

func _ready():
	call_deferred("seeker_setup")

func _physics_process(_delta):
	if target:
		navigation_agent_2d.target_position = target.global_position
		
	if navigation_agent_2d.is_navigation_finished():
		return
	
	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * SPEED
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity_forced(new_velocity)
	else:
		velocity = new_velocity
	
	var collisions = get_slide_collision_count()
	for i in collisions:
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("player"):
			collider.hit(dmg)
	handle_animations()
	move_and_slide()

func seeker_setup():
	await get_tree().physics_frame
	if target:
		navigation_agent_2d.target_position = target.global_position
		
	
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
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
