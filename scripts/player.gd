extends CharacterBody2D
class_name Player

signal damaged

@export var speed = 100
var sprint_speed = 150
var acceleration = 40
var sprint_zoom  = 1.3

var vulnerable = true
var blinking = false
var can_move = true
var can_open_inventory = true
var last_direction = Vector2.RIGHT
var current_speed = speed
var current_zoom = 1
@export var max_health = 6
@export var max_mana = 3


@onready var anim = %Sprite
@onready var inventory_ui = $InventoryUI


var actual_actionable : Actionable = null
var closest_grass_area : Node2D

func _ready():
	InventoryManager.set_player_reference(self)
	EffectManager.set_player_reference(self)
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	Global.set_player_node(self)
	if Global.player_save_position:
		global_position = Global.player_save_position


func _process(delta):
	%HealthBar.health = Global.player_health


func _on_spawn(position : Vector2, direction : String):
	global_position = position
	anim.play("walk_" + direction)


func player_movement():
	var move = Input.get_vector("left", "right", "up", "down") as Vector2
	if move != Vector2.ZERO:
		last_direction = move.normalized()
	if move.x < 0: 
		%Sprite.flip_h = true
		%Sprite.play("walk_right")
	elif move.x > 0: 
		%Sprite.flip_h = false
		%Sprite.play("walk_right")
	elif move.y < 0:
		%Sprite.play("walk_up")
	elif move.y > 0:
		%Sprite.play("walk_down")
	velocity = move * current_speed

func update_anim():
	if velocity.length() == 0:
		if %Sprite.is_playing():
			%Sprite.stop()
	

func _physics_process( delta ):
	if Input.is_action_pressed("run"):
		current_speed += delta * acceleration
		current_zoom += delta * 2
	else:
		current_speed -= delta * acceleration
		current_zoom -= delta * 2

	current_speed = clamp( current_speed, speed, sprint_speed ) 
	current_zoom  = clamp( current_zoom, 1, sprint_zoom )
	%Sprite.speed_scale = current_speed / speed
	$Camera2D.zoom = Vector2(current_zoom, current_zoom)
	if can_move:
		player_movement()
		move_and_slide()
	update_anim()
	pass

func _input(event):
	if event.is_action_pressed("interact") and actual_actionable != null:
		get_viewport().set_input_as_handled()
		actual_actionable.interact( self )
	if event.is_action_pressed("inventory") and can_open_inventory:
		%Sprite.stop()
		get_tree().paused = !get_tree().paused
		can_move = !can_move
		inventory_ui.visible = !inventory_ui.visible
		if inventory_ui.visible == false:
			$InventoryUI/AlchemyMenu.clear_slots()
	if event.is_action_pressed("summon_ability"):
		var active_summon = SummonInventory.get_active_summon()
		if active_summon:
			active_summon.overworld_ability()
			%PlayerMana.value = Global.player_mana


func hit(dmg):
	if vulnerable:
		vulnerable = false
		blinking = true
		Global.player_health -= dmg
		$HitDelay.start()
		$Blinking.start()
		damaged.emit()
		if Global.player_health <= 0:
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

func add_health(health_amount):
	Global.player_health += health_amount
	if Global.player_health > max_health:
		Global.player_health = max_health
	print(Global.player_health)


func add_mana(mana_amount : int):
	Global.player_mana += mana_amount
	if Global.player_mana > max_mana:
		Global.player_mana = max_mana
	%PlayerMana.value = Global.player_mana
	

func apply_item_effect(item):
	pass


func add_item( item ):
	%GameMessage.text = "You got %s" % [ item["name"] ]
	%PickupSound.play()
	var tween : Tween = create_tween()
	tween.tween_property( %GameMessage, "modulate", Color.WHITE_SMOKE, 0.3 )
	tween.tween_property( %GameMessage, "modulate", Color.WHITE, 2 )
	tween.tween_property( %GameMessage, "modulate", Color.TRANSPARENT, 0.3 )


func set_can_open_inventory(b):
	can_open_inventory = b

func get_direction() -> Vector2:
	if velocity.length() > 0:
		return velocity.normalized()  
	else:
		return last_direction  

func set_closest_grass_area(grass_area : Node2D):
	closest_grass_area = grass_area

func get_closest_grass_area():
	return closest_grass_area

func set_can_move(b):
	can_move = b


func show_thought( thought : String ):
	%PlayerToughtLabel.text = thought
	%PlayerToughtLabel.visible_characters = 0
	var tween : Tween = create_tween()
	tween.tween_property( %PlayerToughtContainer, "modulate", Color.WHITE, 0.2 )
	tween.tween_property( %PlayerToughtLabel, "visible_characters", 70, 1 )
	tween.tween_property( %PlayerToughtLabel, "visible_characters", 70, 2 )
	tween.tween_property( %PlayerToughtContainer, "modulate", Color.TRANSPARENT, 0.2 )
