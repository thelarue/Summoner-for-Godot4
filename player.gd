extends CharacterBody2D


@export var speed = 100
var current_speed = speed
var sprint_speed = 150
@export var health = 3
@onready var anim = $AnimatedSprite2D
var vulnerable = true
var blinking = false
var can_move = true
@onready var inventory_ui = $InventoryUI


@onready var color_rect = $CollisionShape2D/Camera2D/CanvasLayer/ColorRect

var can_interact = false
var nearest_interactable: Actionable = null

func _ready():
	InventoryManager.set_player_reference(self)
	
func player_movement():
	var move = Input.get_vector("left", "right", "up", "down")
	velocity = move * current_speed

func update_anim():
	if velocity.length() == 0:
		if anim.is_playing():
			anim.stop()
	else:
		var dir = "down"
		$Marker2D.rotation = velocity.angle() - PI/2
		if velocity.x < 0: 
			dir = "right"
			anim.flip_h = true
		elif velocity.x> 0: 
			dir = "right"
			anim.flip_h = false
		elif velocity.y < 0: dir = "up"
		
		anim.play("walk_" + dir)

func _physics_process(delta):
	if Input.is_action_pressed("run"):
		current_speed = sprint_speed
		$CollisionShape2D/Camera2D.zoom = Vector2(1.3, 1.3)
		var material = color_rect.material as ShaderMaterial
		material.set_shader_parameter("vignette_strength", 3.0)
		$AnimatedSprite2D.speed_scale = 2
	else:
		current_speed = speed
		$CollisionShape2D/Camera2D.zoom = Vector2(1, 1)
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
	if event.is_action_pressed("inventory"):
		get_tree().paused = !get_tree().paused
		can_move = !can_move
		inventory_ui.visible = !inventory_ui.visible
		

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
		health -= dmg
		vulnerable = false
		blinking = true
		$HitDelay.start()
		$Blinking.start()
		if health <= 0:
			die()

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

func apply_item_effect(item):
	pass
