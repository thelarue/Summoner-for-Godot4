extends Interactable
	
func _on_interact():
	print("Common battle dialogue")
	Dialogic.start("res://dialogues/debug room/commonBattleConvo.dtl")
	
func _on_actionable_actioned():
	_on_interact()
