extends Actor

onready var nav2d : Navigation2D = $"/root/World/NavMap"
onready var player : KinematicBody2D = $"/root/World/Player"

export var startFollowDist = 500
export var stopFollowDist = 150

func _ready():
	addState("idle")
	addState("following")
	addState("wandering")
	addState("movingAway")
	call_deferred("setState", states.idle)

func stateLogic(delta):
	print(state)
	if state == states.following:
		follow(delta)
		
func getTransition(delta):
	match state:
		states.idle:
			if shouldFollow():
				return states.following
		states.following:
			if !shouldFollow():
				return  states.idle
			else:
				return states.following
		states.wandering:
			pass
		states.movingAway:
			pass
	return null

func enterState(new, old):
	pass

func exitState(old, new):
	pass
	

func follow(delta):
	motionAxis = Vector2.ZERO
	if state == states.following:
		var path = nav2d.get_simple_path(global_position, player.global_position)	
		motionAxis = path[1] - global_position
		motionAxis = motionAxis.normalized()
	
	move(delta)

func shouldFollow() -> bool:
	return global_position.distance_to(player.global_position) > startFollowDist

func shouldStopFollowing():
	return global_position.distance_to(player.global_position) <= stopFollowDist

func shouldMoveAway():
	return global_position.distance_to(player.global_position) <= stopFollowDist
