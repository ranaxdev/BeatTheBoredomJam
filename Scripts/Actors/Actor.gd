extends KinematicBody2D
class_name Actor

""" 
	~~~ MOVEMENT LOGIC ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""
export var MAX_SPEED := 400
export var acceleration := 5000
export var friction := 0.2
var motion := Vector2.ZERO
var motionAxis := Vector2.ZERO

func applyMovement(amount):
	motion += amount
	if motion.length() > MAX_SPEED:
		motion = motion.normalized() * MAX_SPEED

func move(delta):
	if motionAxis.x == 0:
		motion.x = lerp(motion.x, 0, friction)
	if motionAxis.y == 0:
		motion.y = lerp(motion.y, 0, friction)
	applyMovement(motionAxis * acceleration * delta)
	motion = move_and_slide(motion)
	motion

""" 
	~~~ STATE MACHINE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""
var state = null setget setState
var prev_state = null
var states = {} # list of states

onready var parent = get_parent()

func _physics_process(delta):
	if state != null:
		stateLogic(delta)
		var transition = getTransition(delta)
		if transition != null:
			setState(transition)

# ~~~ VIRTUALS ~~~ #
func stateLogic(delta):
	pass
	
func getTransition(delta):
	return null
	
func enterState(new, old):
	pass
	
func exitState(old, new):
	pass

# ~~~ STATE CHANGER ~~~ #
func setState(new):
	prev_state = state
	state = new
	if prev_state != null:
		exitState(prev_state, new)
	if new != null:
		enterState(new, prev_state)

# ~~~ ADD STATES (CAN'T REMOVE THO) ~~~ #
# sort of dynamic enum
func addState(name):
	states[name] = states.size()
