extends TextureProgress

class_name Healthbar

onready var MAX_HEALTH = get_parent().get_parent().maxHealth

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
	self.set_value(float(currentHealth))
	
	# TEMP (For damage testing)
	var playercoord = tilemap.world_to_map(Vector2(player.position.x,player.position.y))
	if(tilemap.get_cellv(playercoord)==3):
		currentHealth-=1
	else:
		currentHealth+=0.5



func _process(delta):
	self.set_value(float(get_parent().get_parent().health))
