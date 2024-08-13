extends Control

const CAMERA_SPEED = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	%Camera.make_current()
	%Credits.text = FileAccess.get_file_as_string("res://scenes/Credits/Credits.txt")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%Camera.position.y += delta * CAMERA_SPEED
	%Camera.offset.x = %Viewport.size.x / 2
	
	if %Camera.position.y > %Credits.size.y + %Credits.position.y + %Viewport.size.y:
		get_tree().change_scene_to_file("res://scenes/main menu/main_menu.tscn")

