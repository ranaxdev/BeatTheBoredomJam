extends Plant
class_name Crop

# Load crop textures
var melonTexture:Texture = preload("res://Assets/crop/watermelon.png")
var wheatTexture:Texture = preload("res://Assets/crop/wheat.png")
var cockTexture:Texture = preload("res://Assets/crop/cock.png")
var turnipTexture:Texture = preload("res://Assets/crop/turnip.png")
var radishTexture:Texture = preload("res://Assets/crop/radish.png")
var tomatoTexture:Texture = preload("res://Assets/crop/tomato.png")
# Dictionary of crops
var CROPS = {
	# WHEAT
	0 : {
		"seed" : "WHEAT_SEED",
		"texture" : wheatTexture,
		"growtime" : 5.0,
		"name" : "WHEAT_CROP"
	}
	,
	# MELON
	1 : {
		"seed" : "MELON_SEED",
		"texture" : melonTexture,
		"growtime" : 10.0,
		"name" : "MELON_CROP"
	}
	,
	# COCK
	2 : {
		"seed" : "COCK_SEED",
		"texture" : cockTexture,
		"growtime" : 20.0,
		"name" : "COCK_CROP"
	}
	,
	# TURNIP
	3 : {
		"seed" : "TURNIP_SEED",
		"texture" : turnipTexture,
		"growtime" : 3.0,
		"name" : "TURNIP_CROP"
	}
	,
	# RADISH
	4 : {
		"seed" : "RADISH_SEED",
		"texture" : radishTexture,
		"growtime" : 3.0,
		"name" : "RADISH_CROP"
	}
	,
	5 : {
		"seed" : "TOMATO_SEED",
		"texture" : tomatoTexture,
		"growtime" : 3.0,
		"name" : "TOMATO_CROP"
	}
}

var cropType:int

var currentStage:int=0 # current stage of growth
var growTimer:Timer=null
var growthDelay:float
var pos:Vector2; # Position vector in world units
var watered:bool = false
var cropTexture
var xregion=0 # Start of sprite sheet (advance as grow stage increases)

# Constructor
func _init(seed_name:String, mappos:Vector2=Vector2()):
	cropType = self.getCropTypeBySeed(seed_name)
	cropTexture = CROPS.get(cropType).get("texture")
	pos = mappos

#***CREATE EVENT***
func _ready():
	# Set grow delay depending on crop
	growthDelay = CROPS.get(cropType).get("growtime")
	# Timer to get to next stage (growing)
	growTimer = Timer.new()
	growTimer.set_one_shot(true)
	growTimer.set_wait_time(growthDelay)
	growTimer.connect("timeout",self,"_onGrowTimerComplete")
	add_child(growTimer)
	

#***RENDER***
func _draw():
	draw_texture_rect_region(cropTexture,Rect2(tilemap.map_to_world(pos).x*4,tilemap.map_to_world(pos).y*4,64,64),Rect2(xregion,0,64,64))
	

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
	if(currentStage>=2):
		return true
	return false

# Get crop type by seed given
func getCropTypeBySeed(seed_name:String) -> int:
	for i in CROPS:
		if(CROPS.get(i).get("seed")==seed_name):
			return i
	return 0

# Get crop name by crop type
func getCropName() -> String:
	return CROPS.get(cropType).get("name")
