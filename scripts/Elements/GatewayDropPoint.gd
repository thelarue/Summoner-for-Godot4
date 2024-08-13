extends Marker2D
class_name GatewayDropPoint

@export var door_tag        : String
@export var spawn_direction : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func drop_player():
	var players = get_tree().get_nodes_in_group( "player" )
	if players.size() == 0: assert( "no player in the scene" ) 
	
	players[0].global_position = global_position
	
	get_tree().paused = true
	var fade_mask = get_viewport().get_camera_2d().find_child("FadeMask")
	fade_mask.modulate = Color.WHITE
	
	var tween  : Tween    = create_tween()
	tween.tween_property( fade_mask, "modulate", Color.TRANSPARENT, 1 )
	tween.finished.connect( tween_finished )


func tween_finished():
	get_tree().paused = false
