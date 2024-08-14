extends Control

@onready var item_icon = $ItemIcon
@onready var item_quantity = $ItemIcon/ItemQuantity
@onready var details_panel = $DetailsPanel
@onready var item_name = $DetailsPanel/ItemName
@onready var item_type = $DetailsPanel/ItemType
@onready var item_effect = $DetailsPanel/ItemEffect
@onready var usage_panel = $UsagePanel

var item = null



func _input(event):
	if event is  InputEventMouseButton and event.pressed:
		var click_position = event.position
		
		if usage_panel.visible and not usage_panel.get_global_rect().has_point(click_position):
			usage_panel.visible = false

func _on_item_button_mouse_entered():
	if item != null:
		usage_panel.visible = false
		details_panel.visible = true

func _on_item_button_pressed():
	if item != null:
		details_panel.visible = false
		usage_panel.visible = !usage_panel.visible

func _on_item_button_mouse_exited():
	details_panel.visible = false

func set_empty():
	item_icon.texture = null
	item_quantity.text = ""

func set_item(new_item):
	item = new_item
	item_icon.texture = new_item["texture"]
	item_quantity.text = str(item["quantity"])
	item_name.text = str(item["name"])
	item_type.text = str(item["type"])
	if item["effect"] != "":
		item_effect.text = str(item["effect"])
	else:
		item_effect.text = ""
	
func _on_drop_button_pressed():
	if item != null:
		var drop_position = InventoryManager.player_node.global_position
		var drop_offset = Vector2(0, 30)
		drop_offset = drop_offset.rotated(InventoryManager.player_node.get_node("Marker2D").rotation)
		InventoryManager.remove_item(item["name"])
		usage_panel.visible = false


func _on_use_button_pressed():
	if item != null and EffectManager.has_method(item["method"]):
		if EffectManager.call(item["method"], item):
			print(item["consumable"])
			if item["consumable"]:
				print("Removing " + item["name"])
				InventoryManager.remove_item(item["name"])
		usage_panel.visible = false
	InventoryManager.inventory_item_used( item )

func close_usage_panel():
	usage_panel.visible = false


