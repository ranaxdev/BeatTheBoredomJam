extends ItemList

onready var ITEMS = get_node("../ItemDB")
onready var equipButton = get_node("../Equip/Button")
onready var unequipButton = get_node("../Equip/UnequipButton")

func _ready():
	add_to_inv(1,"WHEAT_SEED")
	add_to_inv(1,"TURNIP_SEED")
	add_to_inv(1,"TOMATO_SEED")
	add_to_inv(1,"COCK_SEED")
	add_to_inv(1,"MELON_SEED")
	add_to_inv(1,"RADISH_SEED")
	add_to_inv(1,"STRAWBERRY_SEED")
	add_to_inv(1,"BLUEBERRY_SEED")

# *** UPDATE EVENT ***
func _process(delta):
	if(self.is_anything_selected() and equipButton.pressed):
		ITEMS.set_equipped(get_item_metadata(get_selected_items()[0]))
	
	if(ITEMS.is_equipped() and unequipButton.pressed):
		ITEMS.unequip()
	
	# Update items
	_update_item_amounts()
	_remove_empty_items()


# Update item amounts (by adjusting name)
func _update_item_amounts() -> void:
	for i in range(get_item_count()):
		if(get_item_metadata(i)!=null):
			set_item_text(i, ITEMS.get_formal_name(get_item_metadata(i))+" : "+str(ITEMS.get_amount(get_item_metadata(i))))


# Remove items after running out
func _remove_empty_items() -> void:
	for i in range(get_item_count()):
		if(get_item_metadata(i)!=null):
			if(ITEMS.get_amount(get_item_metadata(i)) <=0):
				# Unequip it if it's equipped
				if(ITEMS.is_this_equipped(get_item_metadata(i))):
					ITEMS.unequip()
				# Remove the item from inventory
				remove_item(i)


# Add specified item (meta name) to inventory with amount
func add_to_inv(amount:int, item_name:String):
	if(!exists_in_inv(item_name)):
		add_item(ITEMS.get_formal_name(item_name)+" : "+str(ITEMS.get_amount(item_name)),ITEMS.get_texture(item_name))
		ITEMS.set_amount(item_name,amount) # Update amount
		# Set item name and usage
		set_item_metadata(get_item_count()-1,item_name)
	else:
		ITEMS.set_amount(item_name,ITEMS.get_amount(item_name)+amount)


# *** GETTERS ***

# Return true if item exists in inv
func exists_in_inv(item_name:String) -> bool:
	for i in range(get_item_count()):
		if(get_item_metadata(i)==item_name):
			return true
	return false

