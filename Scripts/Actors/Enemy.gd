extends Actor

onready var charSprite := $Sprite
onready var weapon := $Weapon
onready var weaponTimer := $WeaponTimer
onready var knockbackTimer := $KnockbackTimer
onready var knockbackTween := $KnockTween
onready var player : KinematicBody2D = $"/root/World/Player"
onready var nav2d : Navigation2D = $"/root/World/NavMap"
var isKnockbacked = false;
var knockbackDirection : Vector2
var shouldFollow = false
var canAttack = true

func _ready():
	addState("idle")
	addState("following")
	addState("knockback")
	addState("attacking")
	call_deferred("setState", states.idle)

func stateLogic(delta):
	for key in states:
		if states[key] == state:
			$Label.set_text(key)
	if canAttack && state != states.knockback:
		weapon.get_node("Collision").disabled = false
		attack()
	else:
		weapon.get_node("Collision").disabled = true
	if state == states.following:
		follow(delta)
		
func getTransition(delta):
	match state:
		states.idle:
			if isKnockbacked:
				return states.knockback
			elif shouldFollow:
				return states.following
		states.following:
			if isKnockbacked:
				return states.knockback
			elif !shouldFollow:
				return states.idle
		states.knockback:
			if !isKnockbacked:
				return states.idle
		states.attacking:
			pass
	
	return null
	
func enterState(new, old):
	match new:
		states.idle:
			charSprite.play("idle")
		states.following:
			charSprite.play("walk")
		states.knockback:
			knockback()
			charSprite.play("knockback")
	
func exitState(old, new):
	match old:
		states.idle:
			charSprite.stop()
		states.following:
			charSprite.stop()
		states.knockback:
			charSprite.stop()

func follow(delta):
	motionAxis = Vector2.ZERO
	if state == states.following:
		var path = nav2d.get_simple_path(global_position, player.global_position)	
		motionAxis = path[1] - global_position
		motionAxis = motionAxis.normalized()
	move(delta)

func attack():
	if canAttack:
		var dir = player.global_position - global_position
		weapon.rotation = dir.angle()

func knockback():
	knockbackDirection = global_position - player.global_position
	knockbackTween.interpolate_property(
			self, #object
			"position", #property
			global_position, #start
			knockbackDirection + global_position, #end
			1, #duration
			Tween.TRANS_BOUNCE, #type
			Tween.EASE_OUT) #type
	knockbackTween.start()

func kill():
	self.queue_free()

func _on_HurtBox_area_entered(area):
	knockbackTimer.start()
	isKnockbacked = true
	damage(30)

func _on_knockbackTimer_timeout():
	isKnockbacked = false

func _on_PlayerDetect_body_entered(body):
	if body == player:
		shouldFollow = true

func _on_Weapon_area_entered(area):
	canAttack = false
	weaponTimer.start()

func _on_WeaponTimer_timeout():
	canAttack = true
