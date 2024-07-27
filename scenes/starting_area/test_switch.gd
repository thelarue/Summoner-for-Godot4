extends Interactable

@onready var sprite = $"."
@onready var sound = preload("res://assets/music and sound/sound fx/lever pull.ogg")
@onready var audioplayer = $"../../soundFX"

var pressed = 0
var player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		_on_interact()
	
func _on_interact():
	audioplayer.play()
	pressed += 1
	if pressed == 1:
		sprite.frame = 2
	elif pressed == 2:
		sprite.frame = 1
	elif pressed == 3:
		sprite.frame = 0
	elif pressed == 4:
		sprite.frame = 1
		pressed = 0
	
func _on_interaction_area_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_interaction_area_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
