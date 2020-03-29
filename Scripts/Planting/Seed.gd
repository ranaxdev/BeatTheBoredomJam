extends Plant

var seedImg:Texture = preload("res://Assets/tempseed.png")
var seededsoilImg:Texture = preload("res://Assets/tempseededsoil.png")

#***CREATE EVENT***
func _ready():
	pass

#***RENDER***
func _draw():
	draw_texture(seedImg,tilemap.map_to_world(mouse_pos),Color(1.0,1.0,1.0,0.5))


#***UPDATE EVENT***
func _process(delta):
	self.visible=false
	if(isWithinReach()):
		if(tilemap.get_cellv(mouse_pos)==TileType.DIRT):
			self.visible=true
	

