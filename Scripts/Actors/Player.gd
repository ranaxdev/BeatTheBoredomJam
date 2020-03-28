extends Actor

func _physics_process(delta):
	motionAxis = getInputAxis()

	
func getInputAxis():
	var axis := Vector2.ZERO
	axis.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	axis.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return axis.normalized()

