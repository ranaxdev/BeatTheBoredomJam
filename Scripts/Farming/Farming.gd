extends Plant

onready var refill_sound = $"/root/World/Audio/Refill"

const MAX_WATER:int=4
const WATERABLE = [TileType.DIRT]
var water_amount:int

func _ready():
	water_amount = MAX_WATER # Initially water bucket is full
	

# *** UPDATE EVENT ***
func _process(delta):
	
	# Water stuff
	refill_water() # Check if player refilled water

# Water tool was used on appropriate tile (waterable)
# Can only be used if water is more than 0
func use_water() -> bool:
	# Use it only if it's on a valid tile
	if(tilemap.get_cellv(player_pos) in WATERABLE and water_amount>0):
		if(Input.is_action_just_pressed("ui_accept") and toolbar.getcurrentTool()==toolbar.getTools().WATER):
			water_amount-=1
			return true
	return false

# Refills water on water tile
func refill_water() -> void:
	# Store tile types adjacent to player
	var adj = [tilemap.get_cell(player_pos.x+1,player_pos.y),tilemap.get_cell(player_pos.x-1,player_pos.y),
	tilemap.get_cell(player_pos.x,player_pos.y+1),tilemap.get_cell(player_pos.x,player_pos.y-1)]
	
	# Check if adjacent tiles were water to refill
	if(TileType.WATER in adj):
		if(Input.is_action_just_pressed("ui_accept") and toolbar.getcurrentTool()==toolbar.getTools().WATER):
			water_amount = MAX_WATER
			refill_sound.play()
# *** GETTERS ***

# Get water amount 
func get_water_amount() -> int:
	return water_amount
