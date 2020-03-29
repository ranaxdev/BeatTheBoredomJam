extends Actor

onready var nav2d : Navigation2D = $"/root/World/NavMap"
onready var player : KinematicBody2D = $"/root/World/Player"

const startFollowDist = 300
const stopFollowDist = 100

var stopped := false

func _ready():
	addState("idle")
	addState("following")
	addState("wandering")
	addState("movingAway")
	call_deferred("setState", states.idle)

func stateLogic(delta):
	for key in states:
		if states[key] == state:
			$Label.set_text(key)
	$Label2.set_text(str(global_position.distance_to(player.global_position)))
	follow(delta)

func getTransition(delta):
	match state:
		states.idle:
			if shouldFollow():
				return states.following
		states.following:
			if shouldStopFollowing():
				return states.idle
		states.wandering:
			pass
		states.movingAway:
			pass
	return null

func enterState(new, old):
	match new:
		states.idle:
			pass
		states.following:
			pass
		states.wandering:
			pass
		states.movingAway:
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
	if global_position.distance_to(player.global_position) > startFollowDist:
		stopped = false
		return true
	return false

func shouldStopFollowing() -> bool:
	if global_position.distance_to(player.global_position) <= stopFollowDist:
		stopped = true
		return true
	return false

func shouldMoveAway() -> bool:
	return global_position.distance_to(player.global_position) <= stopFollowDist
	
