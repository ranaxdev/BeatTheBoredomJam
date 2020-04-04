extends Control

onready var itemlist = self.get_node("ItemList")
onready var equip = self.get_node("Equip")
onready var itemdb = self.get_node("ItemDB")
onready var player = self.get_parent().get_node("./Player")
onready var tooltip = get_node("./Tooltip")
onready var tooltip_text = get_node("./Tooltip/Label")

# *** CREATE EVENT ***
func _ready():
	# Initially inventory is closed (not visible)
	itemlist.visible = false
	equip.visible = false
	tooltip.visible=false
	pause_mode = Node.PAUSE_MODE_PROCESS #Whitelist pause mode

# *** UPDATE EVENT ***
func _process(delta):
	# On inventory toggle
	if(Input.is_action_just_pressed("toggle_inv")):
		# Adjust position
		self.rect_position.x = player.position.x-100
		self.rect_position.y = player.position.y
		
		# Toggle visible
		itemlist.visible = !itemlist.visible
		equip.visible = !equip.visible
		tooltip.visible = !tooltip.visible
		
		# Unselect all items when inv closed
		if(!itemlist.visible):
			itemlist.unselect_all()
	
	# Update equipped conditions
	if(itemdb.is_equipped()):
		# Set texture and item name in equipped panel
		equip.set_selected_texture(itemdb.get_texture(itemdb.get_equipped()))
		equip.set_label_text(itemdb.get_formal_name(itemdb.get_equipped()))
		# Set usage text in tooltip panel
		tooltip_text.set_text(itemdb.get_usage(itemdb.get_equipped()))
	
	# Update unequipped conditions
	if(!itemdb.is_equipped()):
		equip.update_children() # Clear equip panel 
		tooltip_text.set_text("") # Tooltip text to nothing
	
	# Pause rest of the game
	if(itemlist.visible):
		get_tree().paused=true
	else:
		get_tree().paused=false

