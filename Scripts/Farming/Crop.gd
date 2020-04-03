extends Plant
class_name Crop

# Load crop textures
var melonTexture:Texture = preload("res://Assets/crop/watermelon.png")
var wheatTexture:Texture = preload("res://Assets/crop/wheat.png")
var cockTexture:Texture = preload("res://Assets/crop/cock.png")
# Dictionary of crops
var CROPS = {
	# WHEAT
	0 : {
		"seed" : "WHEAT_SEED",
		"texture" : wheatTexture,
		"growtime" : 5
	}
	,
	# MELON
	1 : {
		"seed" : "MELON_SEED",
		"texture" : melonTexture,
		"growtime" : 10
	}
	,
	# COCK
	2 : {
		"seed" : "COCK_SEED",
		"texture" : cockTexture,
		"growtime" : 50
	}
}

var cropType:int;

var currentStage:int=0; # current stage of growth
var growTimer:Timer=null;
var growthDelay:float = 3.0
var pos:Vector2; # Position vector in world units
var watered:bool = false
var cropTexture;
var xregion=0 # Start of sprite sheet (advance as grow stage increases)

# Constructor
func _init(seed_name:String, mappos:Vector2=Vector2()):
	cropType = self.getCropTypeBySeed(seed_name)
	cropTexture = CROPS.get(cropType).get("texture")
	pos = mappos

#***CREATE EVENT***
func _ready():
	# Timer to get to next stage (growing)
	growTimer = Timer.new()
	growTimer.set_one_shot(true)
	growTimer.set_wait_time(growthDelay)
	growTimer.connect("timeout",self,"_onGrowTimerComplete")
	add_child(growTimer)
	

#***RENDER***
func _draw():
	draw_texture_rect_region(cropTexture,Rect2(tilemap.map_to_world(pos),Vector2(64,64)),Rect2(xregion,0,64,64))
#***UPDATE***
func _process(delta):
	pass


# Grow timer complete function
func _onGrowTimerComplete()->void:
	currentStage+=1
	if(currentStage!=3):
		xregion+=64
		update() #Redraw texture
		growTimer.start()
		

# Enable grow timer when watered
func setWatered() -> void:
	if(!watered):
		growTimer.start()
		watered=true

#***GETTERS***

# Return position vector
func getPos() -> Vector2:
	return pos

# Return if it's ready to harvest
func readyToHarvest() -> bool:
	if(currentStage==3):
		return true
	return false

# Get crop type by seed given
func getCropTypeBySeed(seed_name:String) -> int:
	for i in CROPS:
		if(CROPS.get(i).get("seed")==seed_name):
			return i
	return 0
