extends Actor
	
func _ready():
	addState("idle")
	addState("move")
	addState("attack")
	call_deferred("setState", states.idle)

func stateLogic(delta):
	motionAxis = getInputAxis()
	move(delta)

func getTransition(delta):
	match state:
		states.idle:
			if motionAxis != Vector2.ZERO:
				return states.move
		states.move:
			if motionAxis == Vector2.ZERO:
				return states.idle
	return null

func enterState(new, old):
	pass
	
func exitState(old, new):
	pass


func getInputAxis():
	if [states.idle, states.move].has(state):
		return Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		)

