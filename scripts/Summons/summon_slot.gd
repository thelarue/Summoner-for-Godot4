extends Control

@onready var summon_icon = $SummonIcon

var current_summon : Node = null
@onready var usage_panel = $UsagePanel

func set_summon(summon : PackedScene):
	current_summon = summon.instantiate()
	summon_icon.texture = (current_summon.get_node("AnimatedSprite2D") as AnimatedSprite2D).sprite_frames.get_frame_texture("default", 0)
	
func set_empty():
	summon_icon.texture = null

func _on_button_pressed():
	usage_panel.visible = true

func _on_use_button_pressed():
	SummonInventory.set_active_summon(current_summon)
	usage_panel.visible = false
