extends Node
"""
Structure of item database:
	ITEM_NAME : {
		icon : icon_path (string)
		amount : 20 (int)
		equipped : false (bool)
	}
"""

const PATH = "res://Assets/inv_icons/" # Path where all icons are
var equipped = null

# Inventory/World item list
var ITEMS = {
	# Wheat seeds
	"WHEAT_SEED" : {
		"icon" : PATH+"wheat_seed.png",
		"amount" : 0,
	}
	,
	# Cyanide pills (temp)
	"CYANIDE" : {
		"icon" : PATH+"cyanide.png",
		"amount" : 0,
	}
}

# *** SETTERS ***

# Set amount of item
func set_amount(item_name:String, amount:int) -> void:
	ITEMS.get(item_name)["amount"] = amount

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

# Get the current item equipped
func is_equipped(item_name:String) -> bool:
	if(equipped==item_name):
		return true
	return false

# Get a list of all items
func get_items() -> Array:
	var itemArray = []
	for item in ITEMS:
		itemArray.append(item)
	return itemArray
