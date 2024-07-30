extends CharacterBody2D

@export var stats : Resource

func _ready():
	if stats:
		stats.name = "Test"
		stats.type = "Elemental"
		stats.health = 10

func first_ability():
	print("Fire")
