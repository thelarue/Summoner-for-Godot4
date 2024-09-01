extends Control

const SLOT_SCENE = preload("res://scenes/Inventory/inventory_slot.tscn")

@export var inventory : Inventory

signal item_dropped( item_id : String )

var current_slot : InventorySlot

func _ready():
	for i in inventory.slot_count :
		var slot = SLOT_SCENE.instantiate()
		
		if i < inventory.content.size() :
			slot.display_item( inventory.content[i].name, inventory.content[i].qty )
		else :
			slot.display_item( "", 0 )
		slot.pressed.connect( show_tooltip )
		%SlotContainer.add_child(slot)
	
	inventory.content_changed.connect(update_slots)
	%Tooltip.modulate = Color.TRANSPARENT


func _process(_delta):
	if not Rect2( Vector2.ZERO, size ).has_point( get_local_mouse_position() ):
		hide_tooltip()


func update_slots():
	var slots = %SlotContainer.get_children()
	for slot in slots:
		slot.display_item( "", 0 )
	
	var slot_idx = 0
	for content_element in inventory.content :
		slots[slot_idx].display_item( content_element.id, content_element.qty )
		slot_idx += 1


func show_tooltip():
	%TooltipLabel.text = tr("empty_slot")
	var slots = %SlotContainer.get_children()
	for slot in slots :
		var mouse_pos : Vector2i = slot.get_viewport().get_mouse_position()
		var slot_rect : Rect2i   = Rect2i( slot.get_global_rect() )
		if slot_rect.has_point( mouse_pos ) and slot.item_id != "" :
			current_slot = slot
			%TooltipLabel.text = tr( slot.item_id + "_tooltip" )

	var tween : Tween = create_tween( )
	tween.tween_property( %Tooltip, "modulate", Color.WHITE, 0.3 )


func hide_tooltip():
	var tween : Tween = create_tween( )
	if not tween : return
	tween.tween_property( %Tooltip, "modulate", Color.TRANSPARENT, 0.3 )


func _on_visibility_changed():
	hide_tooltip()


func _on_drop_button_pressed():
	inventory.remove_item( current_slot.item_id )


func _on_use_button_pressed():
	var player = find_parent("player")
	var script_file =  "res://scripts/ItemScripts/%s.gd" % current_slot.item_id 
	if not FileAccess.file_exists( script_file ) : return
	var script = load( script_file ).new()
	if script.has_method( "apply_effect_overworld" ):
		script.apply_effect_overworld( player )
