extends Sprite

onready var tilemap:TileMap = $"/root/World/NavMap/TileMap"
onready var player:Actor = self.get_parent();

var map_pos:Vector2
enum TileType {WALL=0, GRASS=1, DIRT=2}

#***CREATE EVENT***
func _ready():
	pass
	

#***UPDATE EVENT***
func _process(delta):
	#TEMP (REFACTOR LATER)
	_beginTrackingMapPos()
	if(Input.is_key_pressed(KEY_SPACE) and tilemap.get_cellv(map_pos)==TileType.GRASS):
		tilemap.set_cellv(map_pos,TileType.DIRT);


#Update cartesian coords into map units on mouse position
func _beginTrackingMapPos():
	map_pos = tilemap.world_to_map(Vector2(get_global_mouse_position().x,get_global_mouse_position().y))
	
