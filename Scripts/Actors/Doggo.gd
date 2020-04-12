extends Actor

onready var nav2d : Navigation2D = $"/root/World/NavMap"
onready var player : KinematicBody2D = $"/root/World/Player"
onready var charSprite : AnimatedSprite = $Sprite

# ~~~ MOVE CONSTS ~~~ #
const startFollowDist := 300
const stopFollowDist := 150
const startMoveAwayDist := 100
const stopMoveAwayDist := 150

var shouldStay := false

# ~~~ INIT STATES ~~~ #
func _ready():
	randomize()
	addState("idle")
	addState("sitting")
	addState("following")
	addState("movingAway")
	call_deferred("setState", states.idle)

func stateLogic(delta):
	if Input.is_action_just_pressed("doggo_stay"):
		toggleStay()
	
	if [states.idle, states.following].has(state):
		follow(delta)
	if state == states.movingAway:
		moveAway(delta)
		
	if motionAxis.x < 0:
		charSprite.flip_h = false
	if motionAxis.x > 0:
		charSprite.flip_h = true


func getTransition(delta):
	match state:
		states.idle:
			if shouldStay:
				return states.sitting
			elif shouldFollow():
				return states.following
			elif shouldMoveAway():
				return states.movingAway
		states.sitting:
			if !shouldStay:
				return states.idle
		states.following:
			if shouldStay:
				return states.sitting
			if shouldStopFollowing():
				return states.idle
		states.movingAway:
			if shouldStopMoveAway():
				return states.idle
	return null

func enterState(new, old):
	match new:
		states.idle:
			charSprite.play("idle")
		states.following:
			charSprite.play("run")
		states.movingAway:
			charSprite.play("run")
		states.sitting:
			charSprite.play("sit")

func exitState(old, new):
	match old:
		states.idle:
			charSprite.stop()
		states.following:
			charSprite.stop()
		states.movingAway:
			charSprite.stop()
		states.sitting:
			charSprite.stop()

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

func toggleStay():
	shouldStay = !shouldStay

func shouldFollow() -> bool:
	return global_position.distance_to(player.global_position) > startFollowDist

func shouldStopFollowing() -> bool:
	return global_position.distance_to(player.global_position) <= stopFollowDist

func shouldMoveAway() -> bool:
	return global_position.distance_to(player.global_position) <= startMoveAwayDist

func shouldStopMoveAway() -> bool:
	return global_position.distance_to(player.global_position) > stopMoveAwayDist
	
