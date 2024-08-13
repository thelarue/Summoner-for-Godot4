extends Node2D

@export var lore_text_file : String

# Called when the node enters the scene tree for the first time.
func _ready():
	%LoreLabel.text = FileAccess.get_file_as_string( "res://loreTexts/" + lore_text_file + ".txt" )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	%LorePanel.visible = %PlayerProximity.has_overlapping_bodies()
	
	if %PlayerProximity.has_overlapping_bodies():
		%Sprite.texture.region.position.x = %Sprite.texture.region.size.x
	else :
		%Sprite.texture.region.position.x = 0
