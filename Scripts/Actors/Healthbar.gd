extends TextureProgress

class_name Healthbar

onready var MAX_HEALTH = get_parent().maxHealth

# preload bar textures
var overImg:Texture = preload("res://Assets/healthbar/over.png")
var underImg:Texture = preload("res://Assets/healthbar/under.png")
var progressImg:Texture = preload("res://Assets/healthbar/progress.png")

var currentHealth:int = 100

func _ready():
	self.set_max(MAX_HEALTH) # Set bar's max val
	self.set_value(MAX_HEALTH) # Start with full health

	# Set bar textures
	self.set_over_texture(overImg)
	self.set_under_texture(underImg)
	self.set_progress_texture(progressImg)

func _process(delta):
	self.set_value(float(get_parent().health))
