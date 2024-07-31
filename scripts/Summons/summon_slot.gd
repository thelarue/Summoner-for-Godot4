extends Control

@onready var summon_icon = $SummonIcon

var current_summon = null

func set_summon(summon : PackedScene):
	current_summon = summon
	var creature = summon.instantiate()
	summon_icon.texture = (creature.get_node("AnimatedSprite2D") as AnimatedSprite2D).sprite_frames.get_frame_texture("default", 0)
	
func set_empty():
	summon_icon.texture = null
