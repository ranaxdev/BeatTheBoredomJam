extends Plant


var dirtTexture:Texture = preload("res://Assets/tempdirt.png")

# Dirt tiles empty or not (dont have crops on them)
var dirtTileEmpty= {}

# Plough timer
var ploughTimer:Timer = null
var ploughDelay:float = 2.0
var canPlough:bool = true

# Revert back to grass timer
var revertTimer:Timer = null
var revertDelay:float = 10.0

#***CREATE EVENT***
func _ready():
	# Plough Timer setup (to wait until next available plough)
	ploughTimer = Timer.new()
	ploughTimer.set_one_shot(true)
	ploughTimer.set_wait_time(ploughDelay)
	ploughTimer.connect("timeout",self,"_onPloughTimerComplete")
	add_child(ploughTimer)
	
	# Revert timer setup
	revertTimer = Timer.new()
	revertTimer.set_one_shot(false)
	revertTimer.set_wait_time(revertDelay)
	revertTimer.connect("timeout",self,"_onRevertTimerComplete")
	add_child(revertTimer)
	
#***UPDATE EVENT***
func _process(_delta):
	self.visible=false #Hide texture
	#Rake is selected to plough
	if(toolbar.getcurrentTool()==toolbar.getTools().RAKE and canPlough):
		plough() # Plough available
	
	

# Plough land function
func plough() -> void:
	#TEMP (REFACTOR LATER)
	#Plough the tile on click
	if(Input.is_key_pressed(KEY_SPACE) and tilemap.get_cellv(player_pos)==TileType.GRASS):
		tilemap.set_cellv(player_pos,TileType.DIRT)
		# Track dirt tile status
		dirtTileEmpty[player_pos] = true
		# Disable ploughing until next available plough
		canPlough=false
		# Restart timers
		ploughTimer.start()
		revertTimer.start()
	print(revertTimer.time_left)

# Enables plough function after timer completes
func _onPloughTimerComplete() -> void:
	canPlough = true;

# Reverts back to grass tile if the dirt tile is empty
func _onRevertTimerComplete() -> void:
	for i in dirtTileEmpty:
		if(dirtTileEmpty.get(i)==true):
			tilemap.set_cellv(i,TileType.GRASS) # set to grass tile
			dirtTileEmpty.erase(i) # Remove from dictionary

