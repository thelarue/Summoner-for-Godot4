extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_door_body_entered(body):
	if not body is Player : return
	if $Door.can_change_scene : return
	body.show_thought( "this door is blocked on the other side" )

# the _body is needed to be able to connect, the other side of the door
func unlock_door(_body):
	$Door.can_change_scene = true
