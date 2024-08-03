extends CharacterBody2D


@export var speed = 100
var current_speed = speed
var sprint_speed = 150
@onready var anim = $AnimatedSprite2D
var vulnerable = true
var blinking = false
var can_move = true
var can_open_inventory = true

@export var max_health = 6

@onready var heart_sprites = [
	$Camera2D/CanvasLayer/PlayerHealth/Heart,
	$Camera2D/CanvasLayer/PlayerHealth/Heart2,
	$Camera2D/CanvasLayer/PlayerHealth/Heart3
]

@onready var inventory_ui = $InventoryUI


@onready var color_rect = $Camera2D/CanvasLayer/ColorRect

var can_interact = false
var nearest_interactable: Actionable = null

func _ready():
	InventoryManager.set_player_reference(self)
	EffectManager.set_player_reference(self)
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	player_health_visual(Global.player_health)
	if Global.player_save_position:
		global_position = Global.player_save_position


func player_health_visual(health : int):
	for i in range(heart_sprites.size()):
		var heart_sprite = heart_sprites[i] as AnimatedSprite2D
		if health >= (i + 1) * 2:
			# Full heart
			heart_sprite.animation = "full_health"
		elif health == (i * 2) + 1:
			# Half heart
			heart_sprite.animation = "damage"
			heart_sprite.frame = 3
		else:
			# Empty heart
			heart_sprite.visible = false
	
func _on_spawn(position : Vector2, direction : String):
	global_position = position
	anim.play("walk_" + direction)
	
func player_movement():
	var move = Input.get_vector("left", "right", "up", "down") as Vector2
	if move.x < 0: 
		anim.flip_h = true
		anim.play("walk_right")
	elif move.x > 0: 
		anim.flip_h = false
		anim.play("walk_right")
	elif move.y < 0:
		anim.play("walk_up")
	elif move.y > 0:
		anim.play("walk_down")
		# Set the Marker2D rotation based on the velocity vector's angle
	if move != Vector2.ZERO:
		$Marker2D.rotation = move.angle()
	velocity = move * current_speed

func update_anim():
	if velocity.length() == 0:
		if anim.is_playing():
			anim.stop()
	

func _physics_process(delta):
	if Input.is_action_pressed("run"):
		current_speed = sprint_speed
		$Camera2D.zoom = Vector2(1.3, 1.3)
		var material = color_rect.material as ShaderMaterial
		material.set_shader_parameter("vignette_strength", 3.0)
		$AnimatedSprite2D.speed_scale = 2
	else:
		current_speed = speed
		$Camera2D.zoom = Vector2(1, 1)
		var material = color_rect.material as ShaderMaterial
		material.set_shader_parameter("vignette_strength", 2.0)
		$AnimatedSprite2D.speed_scale = 1
	if can_move:
		player_movement()
		move_and_slide()
	update_anim()
	pass

func _input(event):
	if event.is_action_pressed("interact") and can_interact:
		get_viewport().set_input_as_handled()
		can_interact = false
		nearest_interactable.emit_signal("actioned")
	if event.is_action_pressed("inventory") and can_open_inventory:
		anim.stop()
		get_tree().paused = !get_tree().paused
		can_move = !can_move
		inventory_ui.visible = !inventory_ui.visible
		if inventory_ui.visible == false:
			$InventoryUI/AlchemyMenu.clear_slots()
		

func _on_area_2d_area_entered(area):
	if area is Actionable:
		can_interact = true
		nearest_interactable = area
		
func _on_area_2d_area_exited(area):
	if area is Actionable:
		can_interact = false
		nearest_interactable = null

func hit(dmg):
	if vulnerable:
		Global.player_health -= dmg
		vulnerable = false
		blinking = true
		play_hit_animation(dmg)
		$HitDelay.start()
		$Blinking.start()
		if Global.player_health <= 0:
			die()

func play_hit_animation(dmg):
	var heart_index = floor(Global.player_health / 2)
	if heart_index >= 0 and heart_index < heart_sprites.size():
		var heart_sprite = heart_sprites[heart_index]
		if dmg == 1 and Global.player_health % 2 != 0:
			heart_sprite.play("damage")
		else:
			heart_sprite.play("damage")
			await(get_tree().create_timer(0.5))
			heart_sprite.play("lose_heart")

	
func die():
	queue_free()
	get_tree().change_scene_to_file("res://scenes/main menu/main_menu.tscn")


func _on_hit_delay_timeout():
	vulnerable = true
	blinking = false
	anim.visible = true

func _on_blinking_timeout():
	if blinking:
		anim.visible = !anim.visible

func add_health(health_amount):
	Global.player_health += health_amount
	for heart in heart_sprites:
		if heart.visible == false:
			heart.visible = true
			break

	
func apply_item_effect(item):
	pass

func set_can_open_inventory(b):
	can_open_inventory = b
