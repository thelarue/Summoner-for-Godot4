extends AnimatedSprite2D
class_name  HealthHeart

enum HeartState { FULL, HALF, EMPTY }

var state : HeartState

func _ready():
	update_animation()

func get_state() -> HeartState:
	return state

func set_state(new_state: HeartState, play_animation : bool):
	state = new_state
	if play_animation:
		update_animation()
	else:
		match new_state:
			HeartState.FULL:
				play("idle")
			HeartState.HALF:
				play("damage")
				frame = 3
			HeartState.EMPTY:
				play("lose_heart")
				frame = 7

func update_animation():
	match state:
		HeartState.FULL:
			play("idle")
		HeartState.HALF:
			play("damage")
		HeartState.EMPTY:
			play("lose_heart")
