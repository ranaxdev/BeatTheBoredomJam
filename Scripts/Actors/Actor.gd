extends KinematicBody2D
class_name Actor

export var MAX_SPEED := 400
export var acceleration := 5000
export var friction := 0.2
var motion := Vector2.ZERO
var motionAxis := Vector2.ZERO


func _physics_process(delta):
	if motionAxis.x == 0:
		motion.x = lerp(motion.x, 0, friction)
	if motionAxis.y == 0:
		motion.y = lerp(motion.y, 0, friction)
	applyMovement(motionAxis * acceleration * delta)
	motion = move_and_slide(motion)

func applyMovement(amount):
	motion += amount
	if motion.length() > MAX_SPEED:
		motion = motion.normalized() * MAX_SPEED
