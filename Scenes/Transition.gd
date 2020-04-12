extends ColorRect

onready var player : KinematicBody2D = $"/root/World/Player"

func doStuff():
	set_global_position(player.global_position - Vector2(600, 400))
	$AnimationPlayer.play("animation")
