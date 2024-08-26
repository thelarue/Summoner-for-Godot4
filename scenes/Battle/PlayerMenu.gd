extends GridContainer

const MENU_TAGS : Array = [ "Actions", "Summons", "Items", "Run" ]

const ITEM_TAGS : Array = [ "sleep powder", "red potion", "black potion", "cheese" ]

var battle_scene : Node2D 
var menu_tags : Array = []
var buttons : Array = []

var button_offset : int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	buttons = %PlayerMenu.get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"): 
		back_to_main_menu()


func enable_player():
	for button in buttons :
		button.disabled = false


func disable_player():
	for button in buttons :
		button.disabled = true


func disconnect_buttons():
	for button in buttons:
		for connection in button.get_signal_connection_list( "pressed" ):
			button.disconnect( "pressed", connection.callable )


func start_change_menu_tags():
	disable_player()
	var tween = create_tween()
	tween.set_parallel( true )
	
	for button in buttons:
		button.custom_minimum_size = button.size
		tween.tween_property( button, "text", "", 0.5 )
	tween.finished.connect( change_menu_tags )


func change_menu_tags():
	var tween = create_tween()
	tween.set_parallel( true )
	
	var idx : int = 0
	for button in buttons:
		button.text = ""
		if idx < menu_tags.size() :
			tween.tween_property( button, "text", menu_tags[idx], 0.5 )
		idx += 1
	tween.finished.connect( enable_player )


func back_to_main_menu():
	disconnect_buttons()
	%MenuButton1.pressed.connect( _actions_menu_pressed )
	%MenuButton2.pressed.connect( _summons_menu_pressed )
	%MenuButton3.pressed.connect( _items_menu_pressed )
	
	%PageUpButton.disabled = true
	%PageDownButton.disabled = true
	
	menu_tags = MENU_TAGS
	start_change_menu_tags()


func _actions_menu_pressed():
	disconnect_buttons()
	menu_tags = []
	var actions = battle_scene.PLAYER_BATTLE_GROUP[ battle_scene.player_selected_unit ].actions
	
	for i in range(4):
		var action_idx = button_offset + i
		if action_idx < actions.size(): 
			menu_tags.push_back( actions[action_idx] ) 
	
	%PageUpButton.disabled = button_offset == 0
	%PageDownButton.disabled = actions.size() <= button_offset + 4
	
	start_change_menu_tags()


func _summons_menu_pressed():
	disconnect_buttons()
	for button in buttons :
		button.connect( "pressed", summon_change_button_pressed )
	menu_tags = []
	for battleant in battle_scene.PLAYER_BATTLE_GROUP :
		menu_tags.push_back( battleant.name ) 
	
	start_change_menu_tags()


func _items_menu_pressed():
	disconnect_buttons()
	menu_tags = ITEM_TAGS
	start_change_menu_tags()


func summon_change_button_pressed():
	var idx : int = 0
	for button in buttons:
		if button.button_pressed and idx < battle_scene.PLAYER_BATTLE_GROUP.size() :
			battle_scene.player_selected_unit = idx
			battle_scene.start_change_summon()
			back_to_main_menu()
		button.button_pressed = false
		idx += 1


func _on_page_down_button():
	button_offset += 4
	_actions_menu_pressed()


func _on_page_up_button():
	button_offset -= 4
	_actions_menu_pressed()
