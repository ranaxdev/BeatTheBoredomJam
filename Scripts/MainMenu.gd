extends MarginContainer

onready var transition = get_parent().get_node("ColorRect")

func _ready():
	transition.visible = false
	transition.get_node("Label").visible = false
	

func _on_Start_button_down():
	#get_tree().change_scene("res://Scenes/World.tscn")
	#get_tree().change_scene("res://Scenes/Transition.tscn")
	transition.visible = true
	transition.get_node("AnimationPlayer").play("animation")
	pass

func _on_Controls_button_down():
	get_tree().change_scene("res://Scenes/UI/Controls.tscn")

func _on_Credits_button_down():
	get_tree().change_scene("res://Scenes/UI/Credits.tscn")

func _on_Quit_button_down():
	get_tree().quit()

func _on_AnimationPlayer_animation_finished(anim_name):
	transition.get_node("Label").visible = true
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/World.tscn")
