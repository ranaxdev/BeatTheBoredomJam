extends Actor

onready var attackArea = $AttackArea
onready var charSprite = $Sprite

func _ready():
	addState("idle")
	addState("move")
	addState("attack")
	call_deferred("setState", states.idle)

func stateLogic(delta):
	motionAxis = getInputAxis()
	if motionAxis.x < 0:
		charSprite.flip_h = true
	if motionAxis.x > 0:
		charSprite.flip_h = false
	move(delta)
	
	if Input.is_action_just_pressed("attack_1"):
		attack()

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
	match new:
		states.idle:
			charSprite.play("idle")
		states.move:
			charSprite.play("walk")
	
func exitState(old, new):
	match old:
		states.idle:
			charSprite.stop()
		states.move:
			charSprite.stop()

func attack():
	var direction := get_local_mouse_position()
	attackArea.rotation = direction.angle()
	attackArea.get_node("Sprite").play()

func getInputAxis():
	if [states.idle, states.move].has(state):
		return Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		)

func _on_Sprite_animation_finished():
	attackArea.get_node("Sprite").stop()
	attackArea.get_node("Sprite").frame = 0
