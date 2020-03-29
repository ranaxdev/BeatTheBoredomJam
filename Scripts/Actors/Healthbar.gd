extends TextureProgress

const MAX_HEALTH:int = 100;

onready var viewport_size:Vector2 = get_parent().get_viewport_rect().size
onready var tilemap:TileMap = $"/root/World/NavMap/TileMap"
onready var player:Actor = self.get_parent().get_parent()

# preload bar textures
var overImg:Texture = preload("res://Assets/healthbar/over.png")
var underImg:Texture = preload("res://Assets/healthbar/under.png")
var progressImg:Texture = preload("res://Assets/healthbar/progress.png")

var currentHealth:int = 100;


func _ready():
	self.set_max(MAX_HEALTH) # Set bar's max val
	self.set_value(MAX_HEALTH) # Start with full health
	 
	# Set bar textures
	self.set_over_texture(overImg)
	self.set_under_texture(underImg)
	self.set_progress_texture(progressImg)
	
	# Adjust position
	self.set_position(Vector2(-overImg.get_width()/2,-viewport_size.y/2+overImg.get_height()/2))
	
func _process(delta):
	# TEMP (For damage testing)
	var playercoord = tilemap.world_to_map(Vector2(player.position.x,player.position.y))
	if(tilemap.get_cellv(playercoord)==3):
		self.set_value(self.get_value()-1)
	else:
		self.set_value(self.get_value()+0.5)


