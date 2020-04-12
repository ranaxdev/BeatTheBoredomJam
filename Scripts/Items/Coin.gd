extends Area2D

onready var player : KinematicBody2D = $"/root/World/Player"

func _on_Coin_body_entered(body):
	if $Timer.is_stopped():
		# addCointToPlayer()
		self.queue_free()

func _on_Timer_timeout():
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = 0
