extends ItemList

onready var ITEMS = get_node("../ItemDB")
onready var equipButton = get_node("../Equip/Button")

func _ready():
	
	# Add items (dynamic adding later)
	add_item("Wheat Seeds: "+str(ITEMS.get_amount("WHEAT_SEED")),ITEMS.get_texture("WHEAT_SEED"))
	set_item_metadata(0, "WHEAT_SEED")
	add_item("Cyanide: "+str(ITEMS.get_amount("CYANIDE")),ITEMS.get_texture("CYANIDE"))
	set_item_metadata(1, "CYANIDE")

func _process(delta):
	if(self.is_anything_selected() and equipButton.pressed):
		ITEMS.set_equipped(get_item_metadata(get_selected_items()[0]))
		print(ITEMS.get_equipped())

