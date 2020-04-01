extends Control

onready var itemlist = self.get_child(0)
onready var player = self.get_parent().get_node("./Player")
func _ready():
	itemlist.visible = false

func _process(delta):
	if(Input.is_action_just_pressed("toggle_inv")):
		# Adjust position
		self.rect_position.x = player.position.x
		self.rect_position.y = player.position.y
		
		itemlist.visible = !itemlist.visible # Toggle visibilty
