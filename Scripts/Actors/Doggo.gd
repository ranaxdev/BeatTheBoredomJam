extends Actor

onready var nav2d : Navigation2D = $"/root/World/NavMap"
onready var player : KinematicBody2D = $"/root/World/Player"

export var startFollowDist = 1000
export var stopFollowDist = 200

var stopTime = 0

func _ready():
	addState("idle")
	addState("following")
	addState("stopping")
	addState("wandering")
	addState("movingAway")
	call_deferred("setState", states.following)

func stateLogic(delta):
	print(state)
	if state == states.following:
		follow(delta)
	if state == states.stopping:
		follow(0)
		stopTime += delta
	
func getTransition(delta):
	match state:
		states.idle:
			if shouldFollow():
				return states.following
		states.following:
			if shouldStopFollowing():
				return states.stopping
		states.stopping:
			if stopTime > 0.5:
				stopTime = 0
				return states.idle
	return null

func enterState(new, old):
	pass

func exitState(old, new):
	pass
	

func follow(delta):
	motionAxis = Vector2.ZERO
	var path = nav2d.get_simple_path(global_position, player.global_position)	
	motionAxis = path[1] - global_position
	motionAxis = motionAxis.normalized()
	
	move(delta)

func shouldFollow():
	return global_position.distance_to(player.global_position) > startFollowDist

func shouldStopFollowing():
	return global_position.distance_to(player.global_position) <= stopFollowDist

func shouldMoveAway():
	return global_position.distance_to(player.global_position) <= stopFollowDist
