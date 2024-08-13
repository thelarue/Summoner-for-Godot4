extends Resource

@export var name : String
@export var type : String
@export var health : int

func _init(p_name = "", p_type = "", p_health = 0):
	name = p_name
	type = p_type
	health = p_health

func get_creature_name():
	return name

func get_creature_type():
	return type

func get_creature_health():
	return health
