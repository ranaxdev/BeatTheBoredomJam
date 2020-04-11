extends Node
var screen_size = OS.get_screen_size();
var window_size = OS.get_window_size();

func _enter_tree():
	OS.set_window_position(screen_size*0.5 - window_size*0.5);
	#OS.set_window_fullscreen(true)
	
#***CREATE EVENT***
func _ready():
	pass;

#***UPDATE EVENT***
func _process(delta):
	pass;
