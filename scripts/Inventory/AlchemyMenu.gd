extends Control

var first_item = null
var second_item = null
var brewed_item = null

func _ready():
	clear_slots()
	%RecipesPanel.modulate = Color.TRANSPARENT


func _process( _delta ):
	for recipedisplay in %RecipeDisplayContainer.get_children():
		recipedisplay.display_recipe( InventoryManager.known_recipes[ recipedisplay.get_index() ] )


func clear_slots():
	%IngredientSlot1.display_item( "", 0 )
	%IngredientSlot2.display_item( "", 0 )
	%ProductSlot.display_item( "", 0 )


func _on_close_button_pressed():
	var tween : Tween = create_tween()
	tween.tween_property( %RecipesPanel, "modulate", Color.TRANSPARENT, 0.3 )


func _on_recipes_button_pressed():
	if %RecipesPanel.modulate == Color.TRANSPARENT :
		var tween : Tween = create_tween()
		tween.tween_property( %RecipesPanel, "modulate", Color.WHITE, 0.3 )
	else :
		var tween : Tween = create_tween()
		tween.tween_property( %RecipesPanel, "modulate", Color.TRANSPARENT, 0.3 )
