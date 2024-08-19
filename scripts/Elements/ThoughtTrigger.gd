extends Area2D

@export var one_shot      : bool = true;
@export var quote         : String = "hmmm."
@export var active        : bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not active : return
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies :
		if body is Player:
			body.show_thought(quote)
			if one_shot : queue_free()
