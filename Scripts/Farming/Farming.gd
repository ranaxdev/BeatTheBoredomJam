extends Plant

const MAX_WATER:int=4
const WATERABLE = [TileType.DIRT]
var water_amount:int

func _ready():
	water_amount = MAX_WATER # Initially water bucket is full


# Water tool was used on appropriate tile (waterable)
# Can only be used if water is more than 0

func use_water() -> bool:
	# Use it only if it's on a valid tile
	if(tilemap.get_cellv(player_pos) in WATERABLE and water_amount>0):
		if(Input.is_action_just_pressed("ui_accept") and toolbar.getcurrentTool()==toolbar.getTools().WATER):
			water_amount-=1
			return true
	return false

