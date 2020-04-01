extends Plant

onready var ploughed = $"/root/World/Farming/Plough"
onready var seeds = $"/root/World/Farming/Seed" 

#***CREATE EVENT***
func _ready():
	pass

#***UPDATE EVENT***
func _process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		harvest()

# Function to harvest the crop once it's fully grown
func harvest():
	for crop in seeds.getPlantedCrops():
		if(crop.getPos()==player_pos and crop.readyToHarvest()):
			seeds.getPlantedCrops().erase(crop) # Remove crop from planted crops list 
			seeds.remove_child(crop) # Remove from memory
			ploughed.dirtTileEmpty[player_pos]=true # Indicate that the tile is empty now
			tilemap.set_cellv(player_pos,TileType.DIRT) # Change texture to regular dirt
			# TEMP - add to crops stat
			toolbar.addCropAmount()
