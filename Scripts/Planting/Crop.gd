extends Plant
class_name Crop

var cropType:int;
var pos:Vector2;

# Constructor
func _init(crop:int=1, mappos:Vector2=Vector2()):
	cropType=crop #Crop type default 1
	pos = mappos


func _ready():
	# Change tile to crop planted tile
	tilemap.set_cellv(pos,TileType.PLANTED)

