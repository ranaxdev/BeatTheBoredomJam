extends Actor

class_name Enemy

onready var charSprite := $Sprite
onready var weapon := $Weapon
onready var weaponTimer := $WeaponTimer
onready var knockbackTimer := $KnockbackTimer
onready var knockbackTween := $KnockTween
onready var lineOfSight := $LineOfSight
onready var player : KinematicBody2D = $"/root/World/Player"
onready var nav2d : Navigation2D = $"/root/World/NavMap"
onready var rootNode := get_node("/root/World")
onready var coin_res := preload("res://Scenes/Items/Coin.tscn")
onready var potion_res := preload("res://Scenes/Items/Potion.tscn")
const sightDistance = 500
var knockbackTestPosition
var isKnockbacked = false;
var shouldFollow = false
var canAttack = true

func _ready():
	randomize()
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
		
	if state == states.knockback:
		if test_move(transform, knockbackTestPosition - global_position):
			knockbackTween.stop(self)
		position = knockbackTestPosition
		
func getTransition(delta):
	match state:
		states.idle:
			if isKnockbacked:
				return states.knockback
			elif shouldFollow():
				return states.following
			elif shouldFollow:
				return states.following
		states.following:
			if isKnockbacked:
				return states.knockback
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
	var knockbackPoint = global_position - player.global_position
	knockbackTween.interpolate_property(
			self, #object
			"knockbackTestPosition", #property
			global_position, #start
			knockbackPoint + global_position, #end
			knockbackTimer.wait_time, #duration
			Tween.TRANS_BOUNCE, #type
			Tween.EASE_OUT) #type
	knockbackTween.start()

func shouldFollow():
	var toPlayer = player.global_position - global_position
	if toPlayer.length() < sightDistance:
		lineOfSight.cast_to = toPlayer * 1.1
		if lineOfSight.is_colliding():
			if lineOfSight.get_collider() == player:
				return true
	return false

func kill():
	#drop stuff
	var item
	if randi() % 2 == 0:
		item = coin_res.instance()
	else: 
		item = potion_res.instance()
	item.global_position = global_position
	rootNode.add_child(item)
	self.queue_free()

func _on_HurtBox_area_entered(area):
	knockbackTimer.start()
	isKnockbacked = true
	damage(50)

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
