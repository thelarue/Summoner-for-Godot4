extends Control

@onready var first_ingredient_image = $FirstIngredient/FirstIngredientImage
@onready var second_ingredient_image = $SecondIngredient/SecondIngredientImage
@onready var result_image = $Result/ResultImage

var first_item = null
var second_item = null
var brewed_item = null

func _ready():
	EffectManager.set_alchemy_menu(self)
	
func set_first_ingredient_image_texture(item_texture):
	first_ingredient_image.texture = item_texture

func set_seccond_ingredient_image_texture(item_texture):
	second_ingredient_image.texture = item_texture

func add_ingredient(item):
	if first_item == null:
		first_item = item
		set_first_ingredient_image_texture(item["texture"])
	elif second_item == null:
		second_item = item
		set_seccond_ingredient_image_texture(item["texture"])
	
func _on_brew_button_pressed():
	if first_item and second_item:
		var brewed_item_data = Recipes.get_recipe_result(first_item["name"], second_item["name"])
		if brewed_item_data:
			brewed_item = create_brewed_item(brewed_item_data)
			clear_ingredients()
			result_image.texture = brewed_item["texture"]
		else:
			print("Invalid combination")

func clear_ingredients():
	first_item = null
	second_item = null
	first_ingredient_image.texture = null
	second_ingredient_image.texture = null

func create_brewed_item(data):
	var new_item = {
		"name": data["name"],
		"type": data["type"],
		"texture": data["texture"],
		"quantity": data["quantity"],
		"scene_path" : data["scene_path"],
		"effect": data["effect"],
		"value": data["value"],
		"method": data["method"]  
	}
	return new_item

func _on_result_button_pressed():
	if InventoryManager.add_item(brewed_item):
		result_image.texture = null
		brewed_item = null

func clear_slots():
	if first_item:
		InventoryManager.add_item(first_item)
	if second_item:
		InventoryManager.add_item(second_item)
	if brewed_item:
		InventoryManager.add_item(brewed_item)
	clear_ingredients()
	result_image.texture = null
	brewed_item = null
	
