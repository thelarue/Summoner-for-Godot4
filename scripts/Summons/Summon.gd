extends CharacterBody2D

class_name Summon

@export var summon_name : String
@export var type : String 
@export var health : int
@export var mana_cost : int

func overworld_ability() -> void:
	pass

func get_creature_name() -> String:
	return summon_name

func get_creature_type() -> String:
	return type

func get_creature_health() -> int:
	return health
