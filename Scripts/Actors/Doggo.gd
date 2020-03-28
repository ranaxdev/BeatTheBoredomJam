extends Actor

onready var nav2d : Navigation2D = $"/root/World/NavMap"
onready var player : KinematicBody2D = $"/root/World/Player"

export var startFollowDist = 200
export var stopFollowDist = 100

func _physics_process(delta):
	motionAxis = Vector2.ZERO
	var distance := global_position.distance_to(player.global_position)
	if distance > startFollowDist:
		var path = nav2d.get_simple_path(global_position, player.global_position)
		
		motionAxis = path[1] - global_position
		motionAxis = motionAxis.normalized()
