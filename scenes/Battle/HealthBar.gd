extends Node2D

const HEARTH_SCENE = preload("res://scenes/utils/player_heart.tscn")
var health : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var health_to_check = health
	var last_heart_position = null
	
	var children = get_children()
	for child in children:
		if health_to_check <= 0:
			child.set_state( HealthHeart.HeartState.EMPTY, child.state != HealthHeart.HeartState.EMPTY )
			health_to_check -= 0
		if health_to_check >= 1:
			child.set_state( HealthHeart.HeartState.HALF, child.state != HealthHeart.HeartState.HALF )
			health_to_check -= 1
		if health_to_check >= 1:
			child.set_state( HealthHeart.HeartState.FULL, child.state != HealthHeart.HeartState.FULL )
			health_to_check -= 1
		
		child.update_animation()
		last_heart_position = child.position
	
	if health_to_check >= 1:
		var heart = HEARTH_SCENE.instantiate()
		add_child(heart)
		heart.position    = last_heart_position
		heart.position.x += 28
		
