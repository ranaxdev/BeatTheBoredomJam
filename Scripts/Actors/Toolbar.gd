extends Sprite

enum Tools {PICKAXE, SWORD, RAKE}
var currentTool = Tools.PICKAXE

var toolbarImg:Texture = preload("res://Assets/temptoolbar.png")
var toolbarWidth:int = 80
var toolbarHeight:int = 32

#***CREATE EVENT***
func _ready():
	pass

#***UPDATE EVENT***
func _process(delta):
	_switchTexture()

#Switch texture depending on currentTool
func _switchTexture():
	#Pickaxe
	if(Input.is_key_pressed(KEY_1)):
		currentTool=Tools.PICKAXE
		set_region_rect(Rect2(0,0,toolbarWidth,toolbarHeight))
	
	#Sword
	elif(Input.is_key_pressed(KEY_2)):
		currentTool=Tools.SWORD
		set_region_rect(Rect2(toolbarWidth,0,toolbarWidth,toolbarHeight))
	
	#Rake
	elif(Input.is_key_pressed(KEY_3)):
		currentTool=Tools.RAKE
		set_region_rect(Rect2(toolbarWidth*2,0,toolbarWidth,toolbarHeight))


#***GETTERS***

#Return the currently selected tool
func getcurrentTool():
	return currentTool

#Return tools list
func getTools():
	return Tools
