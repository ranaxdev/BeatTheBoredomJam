extends Area2D

onready var player : KinematicBody2D = $"/root/World/Player"

func _on_Potion_body_entered(body):
	if $Timer.is_stopped():
		print("yes")
		# addPotionToPlayer()
		self.queue_free()

func _on_Timer_timeout():
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = 0
