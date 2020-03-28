extends Sprite

enum Tools {PICKAXE, SWORD, RAKE};
var currentTool = Tools.PICKAXE;
var toolbarImg = preload("res://Assets/temptoolbar.png");
#***CREATE EVENT***
func _ready():
	pass;

#***UPDATE EVENT***
func _process(delta):
	_switchTexture();

#Switch texture depending on currentTool
func _switchTexture():
	if(Input.is_key_pressed(KEY_1)):
		currentTool=Tools.PICKAXE;
		set_region_rect(Rect2(0,0,80,32));
	elif(Input.is_key_pressed(KEY_2)):
		currentTool=Tools.SWORD;
		set_region_rect(Rect2(80,0,80,32));
	elif(Input.is_key_pressed(KEY_3)):
		currentTool=Tools.RAKE;
		set_region_rect(Rect2(160,0,80,32));
