extends CharacterBody2D


@export var speed = 100
@onready var anim = $AnimatedSprite2D

var can_interact = false
var nearest_interactable: Actionable = null

func player_movement():
	var move = Input.get_vector("left", "right", "up", "down")
	velocity = move * speed

func update_anim():
	if velocity.length() == 0:
		if anim.is_playing():
			anim.stop()
	else:
		var dir = "down"
		$Marker2D.rotation = velocity.angle() - PI/2
		if velocity.x < 0: 
			dir = "right"
			anim.flip_h = true
		elif velocity.x> 0: 
			dir = "right"
			anim.flip_h = false
		elif velocity.y < 0: dir = "up"
		
		anim.play("walk_" + dir)

func _physics_process(delta):
	player_movement()
	move_and_slide()
	update_anim()
	pass

func _unhandled_input(event):
	if event.is_action_pressed("interact") and can_interact:
		get_viewport().set_input_as_handled()
		can_interact = false
		nearest_interactable.emit_signal("actioned")
		
		
func _process(delta):
	pass

func _on_area_2d_area_entered(area):
	if area is Actionable:
		can_interact = true
		nearest_interactable = area
		
func _on_area_2d_area_exited(area):
	if area is Actionable:
		can_interact = false
		nearest_interactable = null
