extends Area2D

@export var speed: float = 300.0

signal fireball_removed

var direction: Vector2

func _process(delta):
	# Move the fireball in the set direction
	position += direction * speed * delta
	var overlapping_bodies = get_overlapping_bodies()
	for body in overlapping_bodies:
		print(body)
		if body is Barrel:
			body.destroy()
		queue_free()
		
func _on_body_entered(body):
	print(body)
	queue_free()

# Sets the direction of the fireball
func set_direction(new_direction: Vector2):
	direction = new_direction.normalized()
	
func _on_timer_timeout():
	fireball_removed.emit()
	queue_free()
