extends Control

onready var cam = get_node("../Player/Camera2D/MerchantTex")
onready var player = get_node("../Player")

func _ready():
	# Exclude from pausing
	pause_mode = Node.PAUSE_MODE_PROCESS
	# Update global position
	self.rect_global_position = cam.rect_global_position

func _process(delta):
	# Update local position
	self.rect_position.x = player.position.x
	self.rect_position.y = player.position.y-200
