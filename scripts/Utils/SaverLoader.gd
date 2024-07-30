class_name SaverLoader
extends Node

@onready var switch = $"../interactives/Switch"
@onready var summon_battle_2 = $"../interactives/summonBattle2"
@onready var boss_battle_2 = $"../interactives/bossBattle2"
@onready var save_point = $"../interactives/savePoint"
@onready var player = $"../player"
@onready var southern_door = $"../bg/southernDoor"

func save():
	var saved_game : SavedGame = SavedGame.new()
	saved_game.switch_frame = switch.frame
	saved_game.player_position = player.global_position
	
	for node in get_tree().get_nodes_in_group("Persist"):
		pass
		
	ResourceSaver.save(saved_game, "user://savegame.tres")

func load():
	var saved_game : SavedGame = load("user://savegame.tres") as SavedGame
	print(saved_game.switch_frame)
	switch.frame = saved_game.switch_frame
	player.global_position = saved_game.player_position
