extends Node2D
class_name Plant

onready var tilemap:TileMap = $"/root/World/NavMap/TileMap Layer 2"
onready var player:Actor = $"/root/World/Player"
onready var toolbar:Sprite = $"/root/World/Player/Camera2D/Toolbar"
onready var inventory = $"/root/World/Inventory/ItemList"
var player_pos:Vector2 #Player position in world units
enum TileType {GRASS=0, WETDIRT=10, DIRT=11, WATER=5}

func _ready():
	pass
	
func _process(delta):	
	updatePlayerPos()
	
# Player cartesian coords to world units
func updatePlayerPos() -> void:
	player_pos = tilemap.world_to_map(Vector2(player.position.x/4,player.position.y/4))

