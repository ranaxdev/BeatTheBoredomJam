extends Actor

onready var nav2d : Navigation2D = $"/root/World/NavMap"
onready var player : KinematicBody2D = $"/root/World/Player"

# ~~~ MOVE CONSTS ~~~ #
const startFollowDist := 300
const stopFollowDist := 150
const startMoveAwayDist := 100
const stopMoveAwayDist := 150

# ~~~ INIT STATES ~~~ #
func _ready():
	randomize()
	addState("idle")
	addState("following")
	addState("movingAway")
	call_deferred("setState", states.idle)

func stateLogic(delta):
	for key in states:
		if states[key] == state:
			$Label.set_text(key)
	$Label2.set_text(str(global_position.distance_to(player.global_position)))
	
	if [states.idle, states.following].has(state):
		follow(delta)
	if state == states.movingAway:
		moveAway(delta)


func getTransition(delta):
	match state:
		states.idle:
			if shouldFollow():
				return states.following
			elif shouldMoveAway():
				return states.movingAway
		states.following:
			if shouldStopFollowing():
				return states.idle
		states.movingAway:
			if shouldStopMoveAway():
				return states.idle
	return null

func enterState(new, old):
	match new:
		states.idle:
			pass
		states.following:
			pass
		states.movingAway:
			pass

func exitState(old, new):
	match old:
		states.idle:
			pass
		states.following:
			pass
		states.movingAway:
			pass

func follow(delta):
	motionAxis = Vector2.ZERO
	if state == states.following:
		var path = nav2d.get_simple_path(global_position, player.global_position)	
		motionAxis = path[1] - global_position
		motionAxis = motionAxis.normalized()
	move(delta)

func moveAway(delta):
	motionAxis = Vector2.ZERO
	if state == states.movingAway:
		var path = nav2d.get_simple_path(global_position, player.global_position)	
		motionAxis = path[1] - global_position
		motionAxis = -motionAxis.normalized()
	move(delta)

func shouldFollow() -> bool:
	return global_position.distance_to(player.global_position) > startFollowDist

func shouldStopFollowing() -> bool:
	return global_position.distance_to(player.global_position) <= stopFollowDist

func shouldMoveAway() -> bool:
	return global_position.distance_to(player.global_position) <= startMoveAwayDist

func shouldStopMoveAway() -> bool:
	return global_position.distance_to(player.global_position) > stopMoveAwayDist
	
