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
var wheat_texture:Texture = preload("res://Assets/inv_icons/wheat_seed.png")
var cyanide_texture:Texture = preload("res://Assets/inv_icons/cyanide.png")

const PATH = "res://Assets/inv_icons/" # Path where all icons are
var equipped = null

# Inventory/World item list
var ITEMS = {
	# Wheat seeds
	"WHEAT_SEED" : {
		"icon" : PATH+"wheat_seed.png",
		"amount" : 20,
		"formal" : "Wheat seeds",
		"texture" : wheat_texture
	}
	,
	# Cyanide pills (temp)
	"CYANIDE" : {
		"icon" : PATH+"cyanide.png",
		"amount" : 0,
		"formal" : "Cyanide",
		"texture" : cyanide_texture
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

# *** GETTERS ***

# Get amount of inputted item
func get_amount(item_name:String) -> int:
	return ITEMS.get(item_name).get("amount")

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

# Get path to the icon
func get_icon_path(item_name:String) -> String:
	return ITEMS.get(item_name).get("icon")

# Get texture
func get_texture(item_name:String) -> Texture:
	return ITEMS.get(item_name).get("texture")

# Get a list of all items
func get_items() -> Array:
	var itemArray = []
	for item in ITEMS:
		itemArray.append(item)
	return itemArray

# Get currently equipped item
func get_equipped() -> String:
	return equipped

# Get formal name
func get_formal_name(item_name:String) -> String:
	return ITEMS.get(item_name).get("formal")
