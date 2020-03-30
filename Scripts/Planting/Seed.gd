extends Plant

const Crop = preload("res://Scripts/Planting/Crop.gd")
"""
seedType - the current seed equipped from inventory
when inventory management system is made later make sure
to accomdate it (maybe enum with list of seed types)
also 0/null if none selected
"""
var seedType:int = 1;
var seedSelected:bool = true;  # A seed is equipped, leave true for now
var plantedCrops = Array() # List of unharvest, planted crops

#***CREATE EVENT***
func _ready():
	pass

#***UPDATE EVENT***
func _process(delta):
	# Seed is equipped and space pressed
	if(seedSelected and Input.is_action_just_pressed("ui_accept")):
		plantCrop()


# Plants seed on dirt tile
func plantCrop() -> void:
	if(tilemap.get_cellv(player_pos)==TileType.DIRT):
		# Plant crop into dirt if there isn't already one planted
		if(!cropMatchesPlayer()):
			var crop = Crop.new(1,player_pos)
			add_child(crop)
			plantedCrops.append(crop)
	
	print(get_child_count())
	print(plantedCrops)

# Return true if overlap between player and a crop
func cropMatchesPlayer() -> bool:
	for i in plantedCrops:
		if(i.getPos()==player_pos):
			return true
	return false
	
