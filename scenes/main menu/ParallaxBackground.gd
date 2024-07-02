extends ParallaxBackground
# Code taken from Joschi - https://forum.godotengine.org/t/how-do-i-make-a-mouse-moving-parrallax-start-screen/21088
# Something about this code makes my parallaxes need to be somewhere crazy on the 2D plane.
# TO DO : Write my own version and fix that issue.

var viewport_size
var relative_x
var relative_y

func _ready():
	# get_tree().get_root().connect("size_changed", self, "viewport_changed") # register event if viewport changes
	# Code above doesn't work, because this node cannot reference itself among other things.
	viewport_changed()
	relative_x = 0
	relative_y = 0

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_x = event.position.x
		var mouse_y = event.position.y
		relative_x = -.5 * (mouse_x - (viewport_size.x/2)) / (viewport_size.x/2)
		relative_y = -.5 * (mouse_y - (viewport_size.y/2)) / (viewport_size.y/2)
		# print("relative_y: " + str(relative_y))
		# print("relative_x: " + str(relative_x))
		var count = 3
		for child in self.get_children(): # for each parallaxlayer do...
			child.motion_offset.x = count * relative_x
			child.motion_offset.y = count * relative_y
			count = count * 1.6

# gets called on the start of the application once and every time the viewport changes
# centers the images
func viewport_changed():
	viewport_size = get_viewport().size
	for child in self.get_children():
		child.get_node("Sprite2D").offset.x = viewport_size.x / 2
		child.get_node("Sprite2D").offset.y = viewport_size.y / 2
