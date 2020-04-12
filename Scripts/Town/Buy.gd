extends ItemList

onready var itemdb = $"/root/World/Inventory/ItemDB"
onready var inv = $"/root/World/Inventory/ItemList"
onready var money = get_node("MoneyDisplay/Amount")
onready var buybutton = get_node("MoneyDisplay/BuyButton")
onready var goldlabel = get_node("../InventoryTitle/GoldLabel")
onready var sell = get_node("../Sell")
onready var coin_sound = $"/root/World/Audio/Coin"

# List of items available in the shop
var shopitems = ["WHEAT_SEED","MELON_SEED","CARROT_SEED","TURNIP_SEED","RADISH_SEED","TOMATO_SEED",
"STRAWBERRY_SEED","BLUEBERRY_SEED","HEALTH_POTION"]

# *** CREATE ***
func _ready():
	# Add items to shop
	for i in shopitems:
		add_item(itemdb.get_formal_name(i),itemdb.get_texture(i))
		set_item_metadata(get_item_count()-1,i)

# *** UPDATE ***
func _process(delta):
	_update_price_display()


# Buy selected item
func _buy_selected_item() -> void:
	if(is_anything_selected() and buybutton.pressed):
		# Increase item amount from inventory if you can afford it
		if(itemdb.get_shekels()-itemdb.get_price(get_item_metadata(get_selected_items()[0]))>=0):
			inv.add_to_inv(1,get_item_metadata(get_selected_items()[0]))
			# Decrease shekels and update label
			itemdb.remove_shekels(itemdb.get_price(get_item_metadata(get_selected_items()[0])))
			goldlabel.set_text(str(itemdb.get_shekels()))
			inv.pause_mode =Node.PAUSE_MODE_PROCESS
			inv.update()
			sell.clear()
			sell._display_crops()
			sell.update()
			coin_sound.play()

	# Update stuff
# Update price display of selected item
func _update_price_display()-> void:
	if(is_anything_selected()):
		money.set_text(str(itemdb.get_price(get_item_metadata(get_selected_items()[0]))))
	elif(get_selected_items().size()==0):
		money.set_text("")


# *** SIGNALS ***
func _on_BuyButton_button_up():
	_buy_selected_item()
