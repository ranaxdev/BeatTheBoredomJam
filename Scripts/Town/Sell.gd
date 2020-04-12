extends ItemList

onready var inv = self.get_node("../../Inventory/ItemDB")
onready var money = self.get_node("MoneyDisplay/Amount")
onready var sell_button = self.get_node("MoneyDisplay/SellButton")
onready var goldlabel = self.get_node("../InventoryTitle/GoldLabel")
# Defining list of crops
var croplist = ["WHEAT_CROP", "MELON_CROP", "CARROT_CROP", "TURNIP_CROP","RADISH_CROP","TOMATO_CROP","STRAWBERRY_CROP","BLUEBERRY_CROP",
"WHEAT_SEED","MELON_SEED","CARROT_SEED","TURNIP_SEED","RADISH_SEED","TOMATO_SEED","STRAWBERRY_SEED","BLUEBERRY_SEED","HEALTH_POTION"]

# *** CREATE ***
func _ready():
	# Update gold label
	goldlabel.set_text(str(inv.get_shekels()))

# *** UPDATE ***
func _process(delta):
	_update_price_display()
	_update_amounts()
	_update_removal()

# Function displays all crops from inventory in sell panel
func _display_crops() -> void:
	for i in inv.get_items():
		if(i in croplist and inv.get_amount(i)>0):
			add_item(inv.get_formal_name(i)+":  "+str(inv.get_amount(i)),inv.get_texture(i))
			set_item_metadata(get_item_count()-1,i)


# Sell selected item
func _sell_selected_item()->void:
	if(is_anything_selected() and sell_button.pressed):
		# Decrease crop amount from inventory
		inv.decrease_amount(get_item_metadata(get_selected_items()[0]))
		# Increase shekels and update label
		inv.add_shekels(inv.get_price(get_item_metadata(get_selected_items()[0])))
		goldlabel.set_text(str(inv.get_shekels()))

	# Update stuff
# Update price display of selected item
func _update_price_display()-> void:
	if(is_anything_selected()):
		money.set_text(str(inv.get_price(get_item_metadata(get_selected_items()[0]))))
	elif(get_selected_items().size()==0):
		money.set_text("")

# Update amounts of selected items
func _update_amounts() -> void:
	for i in range(get_item_count()):
		if(get_item_metadata(i)!=null):
			set_item_text(i,inv.get_formal_name(get_item_metadata(i))+":  "+str(inv.get_amount(get_item_metadata(i))))

# Update item list removal when reaching 0 amount
func _update_removal() -> void:
	for i in range(get_item_count()):
		if(get_item_metadata(i)!=null):
			if(inv.get_amount(get_item_metadata(i))<=0):
				remove_item(i)


# *** SIGNALS ***

# Sell the item upon pressing the button
func _on_SellButton_button_up():
	_sell_selected_item()
