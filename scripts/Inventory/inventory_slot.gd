extends Control
class_name InventorySlot

const DEFAULT_ICON = preload( "res://assets/item icons/default.png")

var item_id : String = "" 

func display_item( item : String, qty : int ):
	item_id = item
	
	%QuantityLabel.visible = qty > 1
	%QuantityLabel.text = str( qty )
	
	%Texture.visible = qty > 0
	
	var texture_path =  "res://assets/item icons/%s.png" % item
	if FileAccess.file_exists( texture_path ) :
		%Texture.texture = load( texture_path )
	else :
		%Texture.texture = DEFAULT_ICON
