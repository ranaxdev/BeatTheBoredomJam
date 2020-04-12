extends Area2D

onready var player : KinematicBody2D = $"/root/World/Player"
onready var itemdb : Node = $"/root/World/Inventory/ItemDB"
onready var pop_sound = $"/root/World/Audio/Harvest"
func _on_Coin_body_entered(body):
	
	if $Timer.is_stopped():
		addCointToPlayer()
		pop_sound.play()
		self.queue_free()

func _on_Timer_timeout():
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = 0

# Adds random coin amount to inventory
func addCointToPlayer() -> void:
	var amount = randi()%50+1
	itemdb.add_shekels(amount)
