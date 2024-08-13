extends Node2D

class_name Spirit

@export var dialogue : String 
@onready var collision_shape_2d : CollisionShape2D = $Actionable/CollisionShape2D

func _ready():
	collision_shape_2d.disabled = true

func set_disabled(b : bool) -> void:
	collision_shape_2d.disabled = b

func _on_actionable_actioned() -> void:
	if dialogue:
		Dialogic.start(dialogue)
	else:
		print("No dialogue")
