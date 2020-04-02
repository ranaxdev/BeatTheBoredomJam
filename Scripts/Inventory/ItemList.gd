extends ItemList

onready var ITEMS = get_node("../ItemDB")
onready var equipButton = get_node("../Equip/Button")

func _ready():
	
	# Add items (dynamic adding later)
	add_item("Wheat Seeds: "+str(ITEMS.get_amount("WHEAT_SEED")),ITEMS.get_texture("WHEAT_SEED"))
	set_item_metadata(0, "WHEAT_SEED")
	add_item("Cyanide: "+str(ITEMS.get_amount("CYANIDE")),ITEMS.get_texture("CYANIDE"))
	set_item_metadata(1, "CYANIDE")
	add_item("Melon Seeds"+str(ITEMS.get_amount("MELON_SEED")),ITEMS.get_texture("MELON_SEED"))
	set_item_metadata(2,"MELON_SEED")


func _process(delta):
	if(self.is_anything_selected() and equipButton.pressed):
		ITEMS.set_equipped(get_item_metadata(get_selected_items()[0]))
	
	# Update items
	_update_item_amounts()
	
# Update item amounts (by adjusting name)
func _update_item_amounts() -> void:
	for i in range(get_item_count()):
		set_item_text(i, ITEMS.get_formal_name(get_item_metadata(i))+": "+str(ITEMS.get_amount(get_item_metadata(i))))
