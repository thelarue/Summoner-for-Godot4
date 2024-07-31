extends Control

@onready var first_item_sprite = $FirstItem/FirstItemSprite
@onready var second_item_sprite = $SecondItem/SecondItemSprite
@onready var third_item_sprite = $ThirdItem/ThirdItemSprite

var first_item = null
var second_item = null
var third_item = null

func _ready():
	EffectManager.set_summoning_menu(self)

func add_summon_ingredient(item):
	if first_item == null:
		first_item = item
		first_item_sprite.texture = item["texture"]
	elif second_item == null:
		second_item = item
		second_item_sprite.texture = item["texture"]
	elif third_item == null:
		third_item = item
		third_item_sprite.texture = item["texture"]

func clear_slots():
	first_item_sprite.texture = null
	second_item_sprite.texture = null
	third_item_sprite.texture = null
	first_item = null
	second_item = null
	third_item = null

func _on_summon_button_pressed():
	if first_item and second_item and third_item:
		var creature = SummonRecipes.get_recipe_result(first_item["name"], second_item["name"], third_item["name"])
		if creature:
			clear_slots()
			var instance = creature.instantiate()
			SummonInventory.add_summon(creature)
			
func get_items_back():
	if first_item:
		InventoryManager.add_item(first_item)
	if second_item:
		InventoryManager.add_item(second_item)
	if third_item:
		InventoryManager.add_item(third_item)


