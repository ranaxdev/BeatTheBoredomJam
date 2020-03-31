extends Actor

onready var nav2d : Navigation2D = $"/root/World/NavMap"
onready var player : KinematicBody2D = $"/root/World/Player"

# ~~~ MOVE CONSTS ~~~ #
const startFollowDist := 300
const stopFollowDist := 150
const startMoveAwayDist := 100
const stopMoveAwayDist := 150

# ~~~ WANDER STUFF ~~~ #
const wanderWaitTime := 3.0
var wanderTimer : Timer
var shouldWander := false

const circleDistance := 60.0
const circleRadius := 20.0
const angleChange := 0.3
var wanderAngle := 0.0
var prevSpeed
const wanderSpeed := 200.0

# ~~~ INIT STATES ~~~ #
func _ready():
	randomize()
	addState("idle")
	addState("following")
	addState("wandering")
	addState("movingAway")
	call_deferred("setState", states.idle)
	
	wanderTimer = Timer.new()
	wanderTimer.set_one_shot(true)
	wanderTimer.set_wait_time(wanderWaitTime)
	wanderTimer.connect("timeout",self,"_onWanderTimerComplete")
	add_child(wanderTimer)

func stateLogic(delta):
	for key in states:
		if states[key] == state:
			$Label.set_text(key)
	$Label2.set_text(str(global_position.distance_to(player.global_position)))
	
	if [states.idle, states.following].has(state):
		follow(delta)
	if state == states.movingAway:
		moveAway(delta)
	if state == states.wandering:
		wander(delta)


func getTransition(delta):
	match state:
		states.idle:
			if shouldFollow():
				return states.following
			elif shouldMoveAway():
				return states.movingAway
			elif shouldWander:
				pass
				#return states.wandering
		states.following:
			if shouldStopFollowing():
				return states.idle
		states.wandering:
			if shouldFollow():
				return states.following
			elif shouldMoveAway():
				return states.movingAway
		states.movingAway:
			if shouldStopMoveAway():
				return states.idle
	return null

func enterState(new, old):
	match new:
		states.idle:
			wanderTimer.start()
		states.following:
			pass
		states.wandering:
			prevSpeed = MAX_SPEED
			MAX_SPEED = wanderSpeed
			pass
		states.movingAway:
			pass

func exitState(old, new):
	match old:
		states.idle:
			pass
		states.following:
			pass
		states.wandering:
			MAX_SPEED = prevSpeed
			shouldWander = false
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

func wander(delta):
	var circleCenter := motion * circleDistance
	var displacement := circleCenter
	
	var _len = displacement.length()
	displacement.x = cos(wanderAngle) * _len
	displacement.y = sin(wanderAngle) * _len
	wanderAngle += (randf() * angleChange) - (angleChange * 0.5)
	motionAxis = (circleCenter + displacement) - global_position
	move(delta)

func shouldFollow() -> bool:
	return global_position.distance_to(player.global_position) > startFollowDist

func shouldStopFollowing() -> bool:
	return global_position.distance_to(player.global_position) <= stopFollowDist

func shouldMoveAway() -> bool:
	return global_position.distance_to(player.global_position) <= startMoveAwayDist

func shouldStopMoveAway() -> bool:
	return global_position.distance_to(player.global_position) > stopMoveAwayDist

func _onWanderTimerComplete():
	shouldWander = true
	
