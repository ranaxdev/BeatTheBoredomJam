extends Sprite

onready var tilemap:TileMap = $"/root/World/NavMap/TileMap"
onready var player:Actor = $"/root/World/Player"

var mouse_pos:Vector2 #Mouse cursor position in world units
var player_pos:Vector2 #Player position in world units
var dirtTexture:Texture = preload("res://Assets/tempdirt.png")
enum TileType {WALL=0, GRASS=1, DIRT=2}

#***CREATE EVENT***
func _ready():
	self.set_texture(dirtTexture)
	pass


#***UPDATE EVENT***
func _process(_delta):
	#TEMP (REFACTOR LATER)
	updateMousePos()
	updatePlayerPos()
	self.visible=false;
	#Limit the reach (2 tiles in each direction)
	if(mouse_pos.x<player_pos.x+2 and mouse_pos.x>player_pos.x-2 and mouse_pos.y>player_pos.y-2 and mouse_pos.y<player_pos.y+2):
		#Texture visible if in reach
		self.visible=true
		#Plough the tile on click
		if(Input.is_mouse_button_pressed(BUTTON_LEFT) and tilemap.get_cellv(mouse_pos)==TileType.GRASS):
			tilemap.set_cellv(mouse_pos,TileType.DIRT)

	
	#Update node position to be mouse position
	self.position = Vector2(get_global_mouse_position().x,get_global_mouse_position().y)
	

#Mouse cartesian coords to world units
func updateMousePos():
	mouse_pos = tilemap.world_to_map(Vector2(get_global_mouse_position().x,get_global_mouse_position().y))


#Player cartesian coords to world units
func updatePlayerPos():
	player_pos = tilemap.world_to_map(Vector2(player.position.x,player.position.y))
