extends Node

func _ready():
	pass


func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/level 1/Level1.tscn")

func _on_load_pressed():
	if FileAccess.file_exists("user://savegame.save"):
		SaverLoader.load_game()
		get_tree().change_scene_to_file("res://scenes/starting_area/start.tscn")


func _on_exit_pressed():
	get_tree().quit()
