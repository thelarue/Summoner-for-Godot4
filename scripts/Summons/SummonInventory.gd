extends Node

signal team_updated

var summons : Array[PackedScene] = []

var player_node : Node = null
var active_summon : Node = null

@onready var summon_slot = load("res://scenes/Summons/summon_slot.tscn")

func _ready():
	summons.resize(3)

func add_summon(summon : PackedScene) -> bool:
	for i in range(summons.size()):
		if summons[i] == null:
			summons[i] = summon
			team_updated.emit()
			if active_summon == null:
				set_active_summon(summon.instantiate())
			return true
	return false

func remove_summon(summon : Node) -> void:
	pass

func set_player_reference(player : Node) -> void:
	player_node = player

func set_active_summon(summon : Node) -> void:
	active_summon = summon
	print(active_summon)

func get_active_summon() -> Node:
	return active_summon
