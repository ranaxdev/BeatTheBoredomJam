extends Node2D
class_name Plant

onready var tilemap:TileMap = $"/root/World/NavMap/TileMap"
onready var player:Actor = $"/root/World/Player"
onready var toolbar:Sprite = $"/root/World/Player/Camera2D/Toolbar"

var player_pos:Vector2 #Player position in world units
enum TileType {WALL=0, GRASS=1, DIRT=2, LAVA=3, WETDIRT=5}

func _ready():
	pass

func _process(delta):
	updatePlayerPos()

# Player cartesian coords to world units
func updatePlayerPos() -> void:
	player_pos = tilemap.world_to_map(Vector2(player.position.x,player.position.y))

