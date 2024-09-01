extends Control

@onready var grid_container = $GridContainer

func _ready():
	SummonInventory.team_updated.connect(_on_team_updated)
	_on_team_updated()


func _on_team_updated():
	clear_grid_container()
	for summon in SummonInventory.summons:
		var slot = SummonInventory.summon_slot.instantiate()
		grid_container.add_child(slot)
		if summon != null:
			slot.set_summon(summon)
		else:
			slot.set_empty()


func clear_grid_container():
	while grid_container.get_child_count() > 0:
		var child = grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free()
