extends MarginContainer



func _on_Start_button_down():
	get_tree().change_scene("res://Scenes/World.tscn")

func _on_Controls_button_down():
	get_tree().change_scene("res://Scenes/UI/Controls.tscn")

func _on_Credits_button_down():
	get_tree().change_scene("res://Scenes/UI/Credits.tscn")

func _on_Quit_button_down():
	get_tree().quit()
