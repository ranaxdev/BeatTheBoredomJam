extends Plant

var Crop = load("res://Scripts/Farming/Crop.gd")
onready var itemdb = self.get_node("../../Inventory/ItemDB")
"""
seedType - the current seed equipped from inventory
when inventory management system is made later make sure
to accomdate it (maybe enum with list of seed types)
also 0/null if none selected
"""
var seedType:int = 1;
var seedSelected:bool = true;  # A seed is equipped, leave true for now
var plantedCrops = Array() # List of unharvest, planted crops
var seed_types = ["WHEAT_SEED","MELON_SEED","COCK_SEED"]

#***CREATE EVENT***
func _ready():
	pass

#***UPDATE EVENT***
func _process(delta):
	# Seed is equipped and space pressed
	if(itemdb.are_these_equipped(seed_types) and Input.is_action_just_pressed("ui_accept")):
		plantCrop()

# Plants seed on dirt/wetdirt tile
func plantCrop() -> void:
	if(tilemap.get_cellv(player_pos) in [TileType.DIRT,TileType.WETDIRT] and toolbar.getcurrentTool()==toolbar.getTools().RAKE):
		# Plant crop into dirt if there isn't already one planted
		if(!cropMatchesPlayer()):
			var crop = Crop.new(itemdb.get_equipped(),player_pos)
			add_child(crop)
			plantedCrops.append(crop)
			# Update dirt tile empty status
			get_node("../Plough/").dirtTileEmpty[player_pos]=false
			# Decrease crop amount in inventory
			itemdb.decrease_amount(itemdb.get_equipped())
			# If it was wet dirt, just start growing
			if(tilemap.get_cellv(player_pos)==TileType.WETDIRT):
				crop.setWatered()

# Return true if overlap between player and a crop
func cropMatchesPlayer() -> bool:
	for i in plantedCrops:
		if(i.getPos()==player_pos):
			return true
	return false
	

# Return planted crops array
func getPlantedCrops() -> Array:
	return plantedCrops
