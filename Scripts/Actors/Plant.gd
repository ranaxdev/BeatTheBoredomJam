extends Sprite

onready var tilemap:TileMap = $"/root/World/NavMap/TileMap"
onready var player:Actor = $"/root/World/Player"
onready var toolbar:Sprite = $"/root/World/Player/Camera2D/Toolbar"

var mouse_pos:Vector2 #Mouse cursor position in world units
var player_pos:Vector2 #Player position in world units
var dirtTexture:Texture = preload("res://Assets/tempdirt.png")
enum TileType {WALL=0, GRASS=1, DIRT=2}

var ploughTimer:Timer = null
var ploughDelay:float = 2.0;
var canPlough:bool = true

#***CREATE EVENT***
func _ready():
	self.set_texture(dirtTexture)
	self.modulate = Color(1.0,1.0,1.0,0.5) #Decrease opacity
	
	# Timer setup (to wait until next available plough)
	ploughTimer = Timer.new()
	ploughTimer.set_one_shot(true)
	ploughTimer.set_wait_time(ploughDelay)
	ploughTimer.connect("timeout",self,"_onPloughTimerComplete")
	add_child(ploughTimer)

#***UPDATE EVENT***
func _process(_delta):
	self.visible=false; #Hide texture
	#Rake is selected to plough
	if(toolbar.getcurrentTool()==toolbar.getTools().RAKE and canPlough):
		plough() # Plough available
		
	
	#Update node position to be mouse position
	self.position = Vector2(get_global_mouse_position().x,get_global_mouse_position().y)
	

func plough():
	#TEMP (REFACTOR LATER)
	updateMousePos()
	updatePlayerPos()
	#Limit the reach (2 tiles in each direction)
	if(mouse_pos.x<player_pos.x+2 and mouse_pos.x>player_pos.x-2 and mouse_pos.y>player_pos.y-2 and mouse_pos.y<player_pos.y+2):
		#Texture visible if in reach
		self.visible=true
		#Plough the tile on click
		if(Input.is_mouse_button_pressed(BUTTON_LEFT) and tilemap.get_cellv(mouse_pos)==TileType.GRASS):
			tilemap.set_cellv(mouse_pos,TileType.DIRT)
			# Disable ploughing until next available plough
			canPlough=false
			# Restart timer
			ploughTimer.start()

func _onPloughTimerComplete():
	canPlough = true;
	

#Mouse cartesian coords to world units
func updateMousePos():
	mouse_pos = tilemap.world_to_map(Vector2(get_global_mouse_position().x,get_global_mouse_position().y))


#Player cartesian coords to world units
func updatePlayerPos():
	player_pos = tilemap.world_to_map(Vector2(player.position.x,player.position.y))
