extends Node
"""
Structure of item database:
	ITEM_NAME : {
		icon : icon_path (string)
		amount : 20 (int)
		index : 0 (int)
	}
"""
# Item textures (make class for this later)
# Potions
var health_texture:Texture = preload("res://Assets/inv_icons/healthpotion.png")
# Seeds
var wheat_texture:Texture = preload("res://Assets/inv_icons/wheat_seed.png")
var melon_texture:Texture = preload("res://Assets/inv_icons/melon_seed.png")
var cyanide_texture:Texture = preload("res://Assets/inv_icons/cyanide.png")
var cock_texture:Texture = preload("res://Assets/inv_icons/cock_seed.png")
var turnip_texture:Texture = preload("res://Assets/inv_icons/turnip_seed.png")
var radish_texture:Texture = preload("res://Assets/inv_icons/radish_seed.png")
var tomato_texture:Texture = preload("res://Assets/inv_icons/tomato_seed.png")
var strawberry_texture:Texture = preload("res://Assets/inv_icons/strawberry_seed.png")
var blueberry_texture:Texture = preload("res://Assets/inv_icons/blueberry_seed.png")
# Crops
var wheatcrop_texture:Texture = preload("res://Assets/inv_icons/wheat_crop.png")
var meloncrop_texture:Texture = preload("res://Assets/inv_icons/melon_crop.png")
var cockcrop_texture:Texture = preload("res://Assets/inv_icons/cock_crop.png")
var turnipcrop_texture:Texture = preload("res://Assets/inv_icons/turnip_crop.png")
var radishcrop_texture:Texture = preload("res://Assets/inv_icons/radish_crop.png")
var tomatocrop_texture:Texture = preload("res://Assets/inv_icons/tomato_crop.png")
var strawberrycrop_texture:Texture = preload("res://Assets/inv_icons/strawberry_crop.png")
var blueberrycrop_texture:Texture = preload("res://Assets/inv_icons/blueberry_crop.png")

var equipped = null
var shekels:int =0

"""
Search categories:
	SEEDS
	CROPS
"""
# Inventory/World item list
var ITEMS = {
		# *** SEEDS ****
	# Wheat seeds
	"WHEAT_SEED" : {
		"amount" : 3,
		"formal" : "WHEAT SEEDS",
		"texture" : wheat_texture,
		"usage" : "WITH RAKE EQUIPPED PRESS SPACE ON DIRT",
		"price" : 1
	}
	,
	# Melon seeds
	"MELON_SEED" : {
		"amount" : 0,
		"formal" : "MELON SEEDS",
		"texture" : melon_texture,
		"usage" : "WITH RAKE EQUIPPED PRESS SPACE ON DIRT",
		"price" : 20
	}
	,
	# Carrot seeds
	"CARROT_SEED" : {
		"amount" : 0,
		"formal" : "CARROT SEEDS",
		"texture" : cock_texture,
		"usage" : "WITH RAKE EQUIPPED PRESS SPACE ON DIRT",
		"price" : 3
	}
	,
	# Turnip seeds
	"TURNIP_SEED" : {
		"amount" : 0,
		"formal" : "TURNIP SEEDS",
		"texture" : turnip_texture,
		"usage" : "WITH RAKE EQUIPPED PRESS SPACE ON DIRT",
		"price" : 2
	}
	,
	# Radish seeds
	"RADISH_SEED" : {
		"amount" : 0,
		"formal" : "RADISH SEEDS",
		"texture" : radish_texture,
		"usage" : "WITH RAKE EQUIPPED PRESS SPACE ON DIRT",
		"price" : 3
	}
	,
	# Tomato seeds
	"TOMATO_SEED" : {
		"amount" : 0,
		"formal" : "TOMATO SEEDS",
		"texture" : tomato_texture,
		"usage" : "WITH RAKE EQUIPPED PRESS SPACE ON DIRT",
		"price" : 4
	}
	,
	# Strawberry seeds
	"STRAWBERRY_SEED" : {
		"amount" : 0,
		"formal" : "STRAWBERRY SEEDS",
		"texture" : strawberry_texture,
		"usage" : "WITH RAKE EQUIPPED PRESS SPACE ON DIRT",
		"price" : 7
	}
	,
	# Blueberry seeds
	"BLUEBERRY_SEED" : {
		"amount" : 0,
		"formal" : "BLUEBERRY SEEDS",
		"texture" : blueberry_texture,
		"usage" : "WITH RAKE EQUIPPED PRESS SPACE ON DIRT",
		"price" : 6
	}
	
	,
	# *** CROPS ****
	# Wheat crop
	"WHEAT_CROP" : {
		"amount" : 0,
		"formal" : "WHEAT",
		"texture" : wheatcrop_texture,
		"usage" : "NONE",
		"price" : 3
	}
	,
	# Melon crop
	"MELON_CROP" : {
		"amount" : 0,
		"formal" : "MELON",
		"texture" : meloncrop_texture,
		"usage" : "NONE",
		"price" : 100
	}
	,
	# Carrot crop
	"CARROT_CROP" : {
		"amount" : 0,
		"formal" : "CARROT",
		"texture" : cockcrop_texture,
		"usage" : "NONE",
		"price" : 8
	}
	,
	# Turnip crop
	"TURNIP_CROP" : {
		"amount" : 0,
		"formal" : "TURNIP",
		"texture" : turnipcrop_texture,
		"usage" : "NONE",
		"price" : 5
	}
	,
	# Radish crop
	"RADISH_CROP" : {
		"amount" : 0,
		"formal" : "RADISH",
		"texture" : radishcrop_texture,
		"usage" : "NONE",
		"price" : 6
	}
	,
	# Tomato crop
	"TOMATO_CROP" : {
		"amount" : 0,
		"formal" : "TOMATO",
		"texture" : tomatocrop_texture,
		"usage" : "NONE",
		"price" : 9
	}
	,
	# Strawberry crop
	"STRAWBERRY_CROP" : {
		"amount" : 0,
		"formal" : "STRAWBERRY",
		"texture" : strawberrycrop_texture,
		"usage" : "NONE",
		"price" : 15
	}
	,
	# Blueberry crop
	"BLUEBERRY_CROP" : {
		"amount" : 0,
		"formal" : "BLUEBERRY",
		"texture" : blueberrycrop_texture,
		"usage" : "NONE",
		"price" : 12
	}
	,
	# Health potion
	"HEALTH_POTION" : {
		"amount" : 0,
		"formal" : "HEALTH POTION",
		"texture" : health_texture,
		"usage" : "",
		"price" : 200
	}
	,
	# Cyanide pills (temp)
	"CYANIDE" : {
		"amount" : 0,
		"formal" : "CYANIDE",
		"texture" : cyanide_texture,
		"usage" : "NONE"
	}
}

# *** SETTERS ***

# Set amount of item
func set_amount(item_name:String, amount:int) -> void:
	ITEMS.get(item_name)["amount"] = amount

# Set equipped
func set_equipped(item_name:String):
	equipped=item_name

# Increase amount of item by 1
func increase_amount(item_name:String):
	set_amount(item_name, get_amount(item_name)+1)

# Decrease amount of item by 
func decrease_amount(item_name:String):
	set_amount(item_name, get_amount(item_name)-1)

# Add to shekels
func add_shekels(amount:int) -> void:
	shekels+=amount

# Remove from shekels
func remove_shekels(amount:int) -> void:
	shekels-=amount

# *** GETTERS ***

# Check if there is an item equipped
func is_equipped() -> bool:
	if(equipped!=null):
		return true
	return false

# Check if given item is equipped
func is_this_equipped(item_name:String)->bool:
	if(item_name==equipped):
		return true
	return false

# Check if any of the given items in the array are equipped
func are_these_equipped(item_names:Array)->bool:
	if(equipped in item_names):
		return true
	return false

# Get currently equipped item
func get_equipped() -> String:
	return equipped

# Unequip anything already equipped
func unequip() -> void:
	equipped=null

# Get texture
func get_texture(item_name:String) -> Texture:
	return ITEMS.get(item_name).get("texture")

# Get a list of all items
func get_items() -> Array:
	var itemArray = []
	for item in ITEMS:
		itemArray.append(item)
	return itemArray

# Get amount of inputted item
func get_amount(item_name:String) -> int:
	return ITEMS.get(item_name).get("amount")

# Get formal name
func get_formal_name(item_name:String) -> String:
	return ITEMS.get(item_name).get("formal")

# Get price
func get_price(item_name:String) -> int:
	return ITEMS.get(item_name).get("price")

# Get usage
func get_usage(item_name:String) -> String:
	return ITEMS.get(item_name).get("usage")

# Get shekels
func get_shekels() -> int:
	return shekels
