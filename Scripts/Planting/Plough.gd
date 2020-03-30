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
	


# Plough land function
func plough() -> void:
	#TEMP (REFACTOR LATER)
	#Plough the tile on click
	if(Input.is_key_pressed(KEY_SPACE) and tilemap.get_cellv(player_pos)==TileType.GRASS):
		tilemap.set_cellv(player_pos,TileType.DIRT)
		# Disable ploughing until next available plough
		canPlough=false
		# Restart timer
		ploughTimer.start()


# Enables plough function after timer completes
func _onPloughTimerComplete() -> void:
	canPlough = true;

