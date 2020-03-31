extends Sprite

enum Tools {PICKAXE, SWORD, RAKE, WATER}
var currentTool = Tools.PICKAXE
var cropAmount:int = 0
var textToDisplay = "PICKAXE"
var font:Font; #temp

#***CREATE EVENT***
func _ready():
	#temp
	$toolLabel.set_size(Vector2(64,64))
	

#***UPDATE EVENT***
func _process(_delta):
	_switchTexture()
	$toolLabel.set_text(textToDisplay)
	$cropLabel.set_text(str(cropAmount)+" CROPS")
#Switch texture depending on currentTool
func _switchTexture():
	#Pickaxe
	if(Input.is_key_pressed(KEY_1)):
		currentTool=Tools.PICKAXE
		textToDisplay = "PICKAXE"
	#Sword
	elif(Input.is_key_pressed(KEY_2)):
		currentTool=Tools.SWORD
		textToDisplay = "SWORD"
	#Rake
	elif(Input.is_key_pressed(KEY_3)):
		currentTool=Tools.RAKE
		textToDisplay = "RAKE"
	#Water
	elif(Input.is_key_pressed(KEY_4)):
		currentTool=Tools.WATER
		textToDisplay = "WATER"
	update()

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
