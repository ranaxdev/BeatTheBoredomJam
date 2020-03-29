extends Sprite
class_name Plant

onready var tilemap:TileMap = $"/root/World/NavMap/TileMap"
onready var player:Actor = $"/root/World/Player"
onready var toolbar:Sprite = $"/root/World/Player/Camera2D/Toolbar"

var mouse_pos:Vector2 #Mouse cursor position in world units
var player_pos:Vector2 #Player position in world units
enum TileType {WALL=0, GRASS=1, DIRT=2}


func _ready():
	pass

func _process(delta):
	updateMousePos()
	updatePlayerPos()
	
# Mouse cartesian coords to world units
func updateMousePos() -> void:
	mouse_pos = tilemap.world_to_map(Vector2(get_global_mouse_position().x,get_global_mouse_position().y))


# Player cartesian coords to world units
func updatePlayerPos() -> void:
	player_pos = tilemap.world_to_map(Vector2(player.position.x,player.position.y))

# Limit reach of planting tile
func isWithinReach() -> bool:
	if(mouse_pos.x<player_pos.x+2 and mouse_pos.x>player_pos.x-2 and mouse_pos.y>player_pos.y-2 and mouse_pos.y<player_pos.y+2):
		return true
	return false
