extends TextureProgress

const MAX_HEALTH:int = 100;

# preload bar textures
var overImg:Texture = preload("res://Assets/healthbar/over.png")
var underImg:Texture = preload("res://Assets/healthbar/under.png")
var progressImg:Texture = preload("res://Assets/healthbar/progress.png")

var currentHealth:int = 100;

func _ready():
	self.set_max(MAX_HEALTH)
	self.set_over_texture(overImg)
	self.set_under_texture(underImg)
	self.set_progress_texture(progressImg)

func _process(delta):
	self.set_value(get_value()+1)
	print(get_value())


