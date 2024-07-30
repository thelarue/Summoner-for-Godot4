extends Node2D

@onready var first_item_sprite = $FirstItem/FirstItemSprite
@onready var second_item_sprite = $SecondItem/SecondItemSprite
@onready var third_item_sprite = $ThirdItem/ThirdItemSprite


var first_item = null
var second_item = null
var third_item = null

var player = null
	
func add_summon_ingredient(item):
	if first_item == null:
		print("Added")
		first_item = item
		first_item_sprite.texture = item["texture"]
	elif second_item == null:
		print("Added")
		second_item = item
		second_item_sprite.texture = item["texture"]
	elif second_item == null:
		third_item = item
		third_item_sprite.texture = item["texture"]


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player.get_node("InventoryUI").visible = false
		player.get_node("InventoryUI/SummoningCircle").visible = false
		player.get_node("InventoryUI/AlchemyMenu").visible = true
		player.set_can_open_inventory(true)
		player = null

func _on_actionable_actioned():
	player.get_node("InventoryUI").visible = true
	player.get_node("InventoryUI/AlchemyMenu").visible = false
	player.get_node("InventoryUI/SummoningCircle").visible = true
	player.set_can_open_inventory(false)
	EffectManager.set_summoning_menu(player.get_node("InventoryUI/SummoningCircle"))
