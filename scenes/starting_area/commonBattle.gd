extends Sprite2D

@onready var interaction_area = $interactionArea

func _on_ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	Dialogic.start("res://dialogues/debug room/commonBattleConvo.dtl")
	
