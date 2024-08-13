extends Control

@onready var summon_icon = $SummonIcon

var current_summon : Node = null
@onready var usage_panel = $UsagePanel
@onready var details_panel = $DetailsPanel
@onready var summon_name = $DetailsPanel/ItemName
@onready var summon_type = $DetailsPanel/ItemType
@onready var summon_health = $DetailsPanel/ItemEffect

func set_summon(summon : PackedScene):
	print(summon_icon.texture)
	current_summon = summon.instantiate() as Summon
	summon_icon.texture = current_summon.get_node("AnimatedSprite2D").sprite_frames.get_frame_texture("default", 0)
	print(summon_icon.texture)
	summon_name.text = current_summon.get_creature_name()
	summon_type.text = current_summon.get_creature_type()
	summon_health.text = str(current_summon.get_creature_health())
	
	
func set_empty():
	summon_icon.texture = null
	summon_name.text = ""
	summon_type.text = ""
	summon_health.text = ""
	
func _on_button_pressed():
	if current_summon:
		details_panel.visible = false
		usage_panel.visible = true

func _on_use_button_pressed():
	SummonInventory.set_active_summon(current_summon)
	usage_panel.visible = false

func _on_button_mouse_entered():
	if current_summon:
		details_panel.visible = true

func _on_button_mouse_exited():
	details_panel.visible = false
