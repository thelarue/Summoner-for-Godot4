extends Area2D

class_name Actionable

signal actioned()

@export var action_text : String = "Use"

func _ready():
	%TipLabel.text = action_text
	var tween : Tween  = create_tween()
	tween.set_loops()
	tween.tween_property( %UseTip, "position", %UseTip.position + Vector2(0, 3 ), 1 )
	tween.tween_property( %UseTip, "position", %UseTip.position, 1 )


func _process(_delta):
	if not monitoring : 
		%UseTip.visible = false
		return
	%UseTip.visible = has_overlapping_bodies()
	
