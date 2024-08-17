extends Node2D

@export var lore_text_file : String

# Called when the node enters the scene tree for the first time.
func _ready():
	%LoreLabel.text = FileAccess.get_file_as_string( "res://loreTexts/" + lore_text_file + ".txt" )


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not %Actionable.has_overlapping_bodies():
		%LorePanel.visible = false
		%Sprite.texture.region.position.x = 0


func _on_actionable_actioned():
	if %LorePanel.visible :
		%LorePanel.visible = false
		%Sprite.texture.region.position.x = 0
	else:
		%LorePanel.visible = true
		%Sprite.texture.region.position.x = %Sprite.texture.region.size.x
