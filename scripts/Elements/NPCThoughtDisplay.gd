extends Node2D
class_name NpcThoughtDisplay

func _process(_delta):
	var dir = Global.player_node.global_position.direction_to( global_position )
	%ToughtPanel.position = get_viewport_rect().get_center()
	%ToughtPanel.position += dir * 120
	
	if Global.player_node.global_position.distance_to( global_position ) < 200 :
		var tmp = global_position - get_viewport().get_camera_2d().global_position
		%ToughtPanel.position = global_position - get_viewport().get_camera_2d().global_position
		%ToughtPanel.position += get_viewport_rect().get_center()
		%ToughtPanel.position -= %ToughtPanel.size / 2
	
	

func show_thought( thought : String ):
	%ToughtLabel.text = thought

	%ToughtLabel.visible_characters = 0
	var tween : Tween = create_tween()
	tween.tween_property( %ToughtPanel, "modulate", Color.WHITE, 0.2 )
	tween.tween_property( %ToughtLabel, "visible_characters", 70, 1 )
	tween.tween_property( %ToughtLabel, "visible_characters", 70, 2 )
	tween.tween_property( %ToughtPanel, "modulate", Color.TRANSPARENT, 0.2 )

