extends Node
class_name Inventory

const DROPPED_ITEM_SCENE = preload("res://scenes/Inventory/DroppedItem.tscn")

signal content_changed


var content : Array = []
var slot_count : int = 8


func _ready():
	for i in range( slot_count ) :
		content.push_back( { "id" : "", "qty" : 0 } )


func add_item( item_id : String, qty : int = 1 ):
	var item = InventoryManager.item_table[item_id]
	for slot in content :
		if ( slot["id"] == item_id and 
			slot["qty"] < item["max_stack"] ):
			var transferred = min( qty, item["max_stack"] - slot["qty"] )
			slot["qty"] += transferred
			qty -= transferred
			content_changed.emit()
			
			if qty <= 0 : return true
			
	# it could not stack existing stacks
	for slot in content :
		if ( slot["id"] == "" and 
			slot["qty"] < item["max_stack"] ):
			var transferred = min( qty, item["max_stack"] )
			slot["qty"] += transferred
			slot["id"] = item_id
			qty -= transferred
			content_changed.emit()
			
			if qty <= 0 : return true
	
	return false


func remove_item( item_id : String, qty : int = 1 ):
	for slot in content :
		if ( slot["id"] == item_id and 
			slot["qty"] >= qty ):
			var transferred = min( qty, slot["qty"] )
			slot["qty"] -= transferred
			qty -= transferred
			_create_dropped_item( item_id, transferred )
			content_changed.emit()

			if qty <= 0 : return true


func _create_dropped_item( item_id : String, qty : int = 1 ):
	var drop : DroppedItem = DROPPED_ITEM_SCENE.instantiate()
	drop.item_id = item_id
	drop.qty = qty
	var dropper = find_parent( "player" )
	dropper.get_parent().add_child( drop )
	drop.scale = Vector2( 0.01, 0.01 )
	drop.position = dropper.position
	
	var tween : Tween = drop.create_tween()
	tween.tween_property( drop, "scale", Vector2.ONE, 0.3 )
