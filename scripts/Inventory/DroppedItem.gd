extends Node2D
class_name DroppedItem


const DEFAULT_ICON = preload( "res://assets/item icons/default.png")

@export var item_id : String = "" 
@export var qty     : int = 1


func _ready():
	var texture_path =  "res://assets/item icons/%s.png" % item_id
	if FileAccess.file_exists( texture_path ) :
		%Texture.texture = load( texture_path )
	else :
		%Texture.texture = DEFAULT_ICON


func _on_actionable_actioned_by(interacting_object):
	if not interacting_object.has_method( "add_item" ) : return
	if not interacting_object.add_item( item_id, qty ) : return
	var tween : Tween = create_tween()
	tween.tween_property( self, "scale", Vector2( 0.01, 0.01 ), 0.3 )
	tween.finished.connect( queue_free )
