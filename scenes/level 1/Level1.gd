extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#Dialogic.start("res://dialogues/debug room/intro.dtl")
	RenderingServer.set_default_clear_color( Color.BLACK )
	%Environment.visible = true
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
