extends Plant
class_name Crop

var cropType:int;
var pos:Vector2; # Position vector in world units
var tempTexture:Texture = preload("res://Assets/tempseed.png")

# Constructor
func _init(crop:int=1, mappos:Vector2=Vector2()):
	cropType=crop #Crop type default 1
	pos = mappos

#***CREATE EVENT***
func _ready():
	pass

func _draw():
	draw_texture(tempTexture,tilemap.map_to_world(pos))

#***GETTERS***

# Return position vector
func getPos() -> Vector2:
	return pos
