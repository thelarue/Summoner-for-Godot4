extends Node

signal team_updated

var summons : Array[PackedScene] = []

var player_node = null

@onready var summon_slot = load("res://scenes/Summons/summon_slot.tscn")

func _ready():
	summons.resize(3)

func add_summon(summon : PackedScene):
	for i in range(summons.size()):
		if summons[i] == null:
			summons[i] = summon
			team_updated.emit()
			return true
	return false

func remove_summon(summon : PackedScene):
	pass

func set_player_reference(player):
	player_node = player
