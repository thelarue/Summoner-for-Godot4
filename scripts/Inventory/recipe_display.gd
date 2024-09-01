extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	%Ingredient1.display_item("", 0)
	%Ingredient2.display_item("", 0)
	%Product.display_item("", 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func display_recipe( recipe ):
	%Ingredient1.display_item( recipe["comp1"], recipe["comp1qty"])
	%Ingredient2.display_item( recipe["comp2"], recipe["comp2qty"] )
	%Product.display_item( recipe["product"], recipe["production"])
