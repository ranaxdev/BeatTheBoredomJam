extends Actor

onready var sword = $Sword
onready var charSprite = $Sprite

var isVulnerable = true
var isDamaged = false

func _ready():
	addState("idle")
	addState("move")
	addState("damaged")
	call_deferred("setState", states.idle)
	sword.get_node("Sprite").frame = 0 # weird sprite behavior if not set 0

func stateLogic(delta):
	# disable sword on next frame
	if !sword.get_node("Collision").disabled:
		sword.get_node("Collision").disabled = true
	
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
			if isDamaged:
				return states.damaged
			if motionAxis != Vector2.ZERO:
				return states.move
		states.move:
			if isDamaged:
				return states.damaged
			if motionAxis == Vector2.ZERO:
				return states.idle
		states.damaged:
			if !isDamaged:
				return states.idle
	return null

func enterState(new, old):
	match new:
		states.idle:
			charSprite.play("idle")
		states.move:
			charSprite.play("walk")
		states.damaged:
			isVulnerable = true
			damage(30)
			charSprite.play("damage")
	
func exitState(old, new):
	match old:
		states.idle:
			charSprite.stop()
		states.move:
			charSprite.stop()
		states.damaged:
			isVulnerable = true
			charSprite.stop()

func attack():
	if sword.get_node("Sprite").frame == 0: # attack only if animation over
		var direction := get_local_mouse_position()
		sword.get_node("Collision").disabled = false
		sword.rotation = direction.angle()
		sword.get_node("Sprite").play()

func getInputAxis():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

func kill():
	# for time being restarts game
	get_tree().reload_current_scene()

func _on_Sprite_animation_finished():
	sword.get_node("Sprite").stop()
	sword.get_node("Sprite").frame = 0

func _on_HurtBox_area_entered(area):
	if area.is_in_group("enemyWeapon"):
		$DmgTimer.start()
		isDamaged = true


func _on_DmgTimer_timeout():
	isDamaged = false
