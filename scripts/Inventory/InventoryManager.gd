extends Node
var item_table    : Dictionary = {}
var recipes       : Array      = []
var known_recipes : Array      = []


func _ready():
	read_item_table()
	read_recipe_table()


func read_item_table():
	#Item ID ,Max stack,Equip tag,Useable in overworld,Usable in battle,Target flags (battle),battle stats (only for equipable),Additional data
	var item_table_file = FileAccess.open( "res://datatables/MainItemList.csv", FileAccess.READ )
	item_table = {}
	
	# get rid of headline
	item_table_file.get_csv_line(",")
	
	while !item_table_file.eof_reached():
		var values = item_table_file.get_csv_line(",")
		if values[0] != "":
			var item : Dictionary = {}
			item["id"]         = values[0]
			item["max_stack"]  = int( values[1] )
			item["equip_tag"]  = values[2]
			item["usable_ow"]  = values[3] == "TRUE"
			item["usable_bt"]  = values[4] == "TRUE"
			item["consumable"] = values[5] == "TRUE"
			item_table[ item["id"] ] = item

	item_table_file.close()


func read_recipe_table():
	#Item ID ,Max stack,Equip tag,Useable in overworld,Usable in battle,Target flags (battle),battle stats (only for equipable),Additional data
	var item_table_file = FileAccess.open( "res://datatables/RecipeList.csv", FileAccess.READ )
	recipes = []
	
	# get rid of headline
	item_table_file.get_csv_line(",")
	
	while !item_table_file.eof_reached():
		var values = item_table_file.get_csv_line(",")
		if values[0] != "":
			var recipe : Dictionary = {}
			recipe["product"]    = values[0]
			recipe["production"] = int( values[1] )
			recipe["comp1"]      = values[2]
			recipe["comp1qty"]   = int( values[3] )
			recipe["comp2"]      = values[4]
			recipe["comp2qty"]   = int( values[5] )
			recipes.push_back( recipe )
			known_recipes.push_back( recipe )

	item_table_file.close()
