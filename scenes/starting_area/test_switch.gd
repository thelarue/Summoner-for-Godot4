extends Sprite2D

@onready var interaction_area: InteractionArea = $interactionArea
@onready var sprite = $"."
@onready var sound = preload("res://assets/music and sound/sound fx/lever pull.ogg")
@onready var audioplayer = $"../../soundFX"

var pressed = 0

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
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
	

