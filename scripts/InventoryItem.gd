@tool
extends Node2D

class_name Item

@export var item_type : String = ""
@export var item_method : String = ""
@export var item_name : String = ""
@export var item_texture : Texture
@export var item_effect : String = ""
@export var effect_value : int = 0

@export var recipe : Array[Item] = []

var scene_path : String = "res://scenes/inventory_item.tscn"

@onready var icon_sprite = $Sprite2D

var player_in_range = false

func _ready():
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture

func _process(delta):
	if Engine.is_editor_hint():
		icon_sprite.texture = item_texture
	if player_in_range and Input.is_action_just_pressed("interact"):
		pickup_item()

func pickup_item():
	var item = {
		"quantity" : 1,
		"type" : item_type,
		"name" : item_name,
		"texture" : item_texture,
		"effect" : item_effect,
		"method" : item_method,
		"value" : effect_value,
 		"scene_path" : scene_path
	}
	if InventoryManager.player_node:
		InventoryManager.add_item(item)
		queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false

func set_item_data(data):
	item_type = data["type"]
	item_name = data["name"]
	item_effect = data["effect"]
	item_texture = data["texture"]
	effect_value = data["value"]
	item_method = data["method"]


	
