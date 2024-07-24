extends Sprite2D
	
func _on_interact():
	Dialogic.start("res://dialogues/debug room/commonBattleConvo.dtl")
	
func _on_actionable_actioned():
	_on_interact()
