extends Area2D

onready var player : KinematicBody2D = $"/root/World/Player"
onready var itemdb : Node = $"/root/World/Inventory/ItemDB"
onready var inventory : ItemList = $"/root/World/Inventory/ItemList"


func _on_Potion_body_entered(body):
	if $Timer.is_stopped():
		addPotionToPlayer()
		self.queue_free()

func _on_Timer_timeout():
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = 0

# Adds potion to inventory
func addPotionToPlayer() -> void:
	inventory.add_to_inv(1,"HEALTH_POTION")
	
