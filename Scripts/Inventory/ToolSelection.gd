extends Control

onready var toolbar = get_node("../../Player/Camera2D/Toolbar")
onready var buttons = get_node("ToolsButton")
onready var water = get_node("../../Farming")
# Button textures
var pickaxeTex = preload("res://Assets/tools/pickaxe.png")
var rakeTex = preload("res://Assets/tools/rake.png")
var bucketTex = preload("res://Assets/tools/bucket.png")


func _ready():
	buttons.add_icon_item(pickaxeTex,"  PICKAXE",0)
	buttons.add_icon_item(rakeTex,"  RAKE",1)
	buttons.add_icon_item(bucketTex,"  BUCKET",2)
	

func _process(delta):
	_update_tool_names()

# Update tool names (incase some amounts need updating e.g.)
func _update_tool_names():
	# Water bucket - update water amount
	buttons.set_item_text(2, "  BUCKET: "+str(water.get_water_amount()))
