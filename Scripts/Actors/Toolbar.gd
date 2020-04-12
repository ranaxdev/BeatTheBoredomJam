extends Sprite

enum Tools {PICKAXE=0, RAKE=1, WATER=2}
var currentTool = Tools.PICKAXE
var cropAmount:int = 0

var font:Font; #temp

#***CREATE EVENT***
func _ready():
	pass
	

#***UPDATE EVENT***
func _process(_delta):
	pass

# Set current tool
func setcurrentTool(current_tool:int)->void:
	currentTool = current_tool

# Add to crop amount
func addCropAmount()->void:
	cropAmount+=1

#***GETTERS***

#Return the currently selected tool
func getcurrentTool():
	return currentTool

#Return tools list
func getTools():
	return Tools
