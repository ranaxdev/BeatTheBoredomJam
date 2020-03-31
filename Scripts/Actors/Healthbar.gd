extends TextureProgress

class_name Healthbar

onready var MAX_HEALTH = get_parent().get_parent().maxHealth

func _ready():
	self.set_max(MAX_HEALTH) # Set bar's max val
	self.set_value(MAX_HEALTH) # Start with full health

func _process(delta):
	self.set_value(float(get_parent().get_parent().health))
