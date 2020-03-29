extends Sprite

onready var tilemap:TileMap = $"/root/World/NavMap/TileMap"
onready var player:Actor = self.get_parent();

var mouse_pos:Vector2
var player_pos:Vector2
enum TileType {WALL=0, GRASS=1, DIRT=2}

#***CREATE EVENT***
func _ready():
	pass
	

#***UPDATE EVENT***
func _process(delta):
	#TEMP (REFACTOR LATER)
	updateMousePos()
	updatePlayerPos()
	
	#Plough the tile on click
	if(Input.is_mouse_button_pressed(BUTTON_LEFT) and tilemap.get_cellv(mouse_pos)==TileType.GRASS):
		#Limit the reach (2 tiles in each direction)
		if(mouse_pos.x<player_pos.x+2 and mouse_pos.x>player_pos.x-2 and mouse_pos.y>player_pos.y-2 and mouse_pos.y<player_pos.y+2):
			tilemap.set_cellv(mouse_pos,TileType.DIRT)
		

#Mouse cartesian coords to world units
func updateMousePos():
	mouse_pos = tilemap.world_to_map(Vector2(get_global_mouse_position().x,get_global_mouse_position().y))


#Player cartesian coords to world units
func updatePlayerPos():
	player_pos = tilemap.world_to_map(Vector2(player.position.x,player.position.y))
