extends Plant
class_name Crop

var cropType:int;
var currentStage:int=0; # current stage of growth
var growTimer:Timer=null;
var growthDelay:float = 3.0
var pos:Vector2; # Position vector in world units
var watered:bool = false
# Texture stuff (Fix later)
var tempTexture:Texture;
var crop1tex = preload("res://Assets/crop/crop1.png")
var crop2tex = preload("res://Assets/crop/crop2.png")
var crop3tex = preload("res://Assets/crop/crop3.png")

var growTextures = [crop1tex,crop2tex,crop3tex]
# Constructor
func _init(crop:int=1, mappos:Vector2=Vector2()):
	cropType=crop #Crop type default 1
	pos = mappos

#***CREATE EVENT***
func _ready():
	tempTexture = crop1tex; #initially its a seed texture
	# Timer to get to next stage (growing)
	growTimer = Timer.new()
	growTimer.set_one_shot(true)
	growTimer.set_wait_time(growthDelay)
	growTimer.connect("timeout",self,"_onGrowTimerComplete")
	add_child(growTimer)
	

#***RENDER***
func _draw():
	draw_texture(tempTexture,tilemap.map_to_world(pos))

#***UPDATE***
func _process(delta):
	pass


# Grow timer complete function
func _onGrowTimerComplete()->void:
	currentStage+=1
	if(currentStage!=3):
		tempTexture = growTextures[currentStage] #Advance texture
		update() #Redraw texture
		growTimer.start()
		

# Enable grow timer when watered
func setWatered() -> void:
	if(!watered):
		growTimer.start()
		watered=true
		print("started")

#***GETTERS***

# Return position vector
func getPos() -> Vector2:
	return pos

# Return if it's ready to harvest
func readyToHarvest() -> bool:
	if(currentStage==3):
		return true
	return false

