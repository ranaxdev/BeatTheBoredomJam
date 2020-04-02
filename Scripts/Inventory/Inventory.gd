extends Control

onready var itemlist = self.get_node("ItemList")
onready var equip = self.get_node("Equip")
onready var itemdb = self.get_node("ItemDB")
onready var player = self.get_parent().get_node("./Player")

# *** CREATE EVENT ***
func _ready():
	itemlist.visible = false
	equip.visible = false
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
		
		# Unselect all items when inv closed
		if(!itemlist.visible):
			itemlist.unselect_all()
	
	# Update equipped texture
	if(itemdb.is_equipped()):
		equip.set_selected_texture(itemdb.get_texture(itemdb.get_equipped()))
		equip.set_label_text(itemdb.get_formal_name(itemdb.get_equipped()))

	# Pause rest of the game
	if(itemlist.visible):
		get_tree().paused=true
	else:
		get_tree().paused=false


# Sets item to currently equipped
