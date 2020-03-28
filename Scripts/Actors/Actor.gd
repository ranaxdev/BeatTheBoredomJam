extends KinematicBody2D
class_name Actor

export var MAX_SPEED := 400
export var acceleration := 5000
var motion := Vector2.ZERO
var motionAxis := Vector2.ZERO


func _physics_process(delta):
	if motionAxis == Vector2.ZERO: # No movement
		applyFriction(acceleration * delta)
	else: # Movement
		applyMovement(motionAxis * acceleration * delta)
	motion = move_and_slide(motion)


# ~~~ MOVING AND STOPPING ~~~ #
func applyFriction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func applyMovement(amount):
	motion += amount
	if motion.length() > MAX_SPEED:
		motion = motion.normalized() * MAX_SPEED
