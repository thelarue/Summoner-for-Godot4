extends Area2D

class_name Actionable

signal actioned()
signal actioned_by( interacting_object : Node2D )

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


func interact( interacting : Node2D ):
	emit_signal("actioned" )
	emit_signal("actioned_by", interacting)


func _on_body_entered(body):
	if "actual_actionable" in body:
		body.actual_actionable = self


func _on_body_exited(body):
	if "actual_actionable" in body:
		body.actual_actionable = null
