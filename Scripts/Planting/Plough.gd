extends Plant

var dirtTexture:Texture = preload("res://Assets/tempdirt.png")
var ploughTimer:Timer = null
var ploughDelay:float = 2.0;
var canPlough:bool = true

#***CREATE EVENT***
func _ready():
	# Timer setup (to wait until next available plough)
	ploughTimer = Timer.new()
	ploughTimer.set_one_shot(true)
	ploughTimer.set_wait_time(ploughDelay)
	ploughTimer.connect("timeout",self,"_onPloughTimerComplete")
	add_child(ploughTimer)

#***UPDATE EVENT***
func _process(_delta):
	self.visible=false #Hide texture
	#Rake is selected to plough
	if(toolbar.getcurrentTool()==toolbar.getTools().RAKE and canPlough):
		plough() # Plough available
	

#***RENDER***
func _draw():
	# Draw the transluscent hovering tile
	draw_texture(dirtTexture,tilemap.map_to_world(mouse_pos),Color(1.0,1.0,1.0,0.5))

# Plough land function
func plough() -> void:
	#TEMP (REFACTOR LATER)
	#Limit the reach (2 tiles in each direction)
	if(isWithinReach()):
		#Texture visible if in reach and on grass
		if tilemap.get_cellv(mouse_pos)==TileType.GRASS:
			self.visible=true
		#Plough the tile on click
		if(Input.is_mouse_button_pressed(BUTTON_LEFT) and tilemap.get_cellv(mouse_pos)==TileType.GRASS):
			tilemap.set_cellv(mouse_pos,TileType.DIRT)
			# Disable ploughing until next available plough
			canPlough=false
			# Restart timer
			ploughTimer.start()


# Enables plough function after timer completes
func _onPloughTimerComplete() -> void:
	canPlough = true;
