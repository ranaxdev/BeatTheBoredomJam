extends Node2D

export var spawnTimer : int = 5
export var minAmount : int = 2
export var maxAmount : int = 5

onready var spawnCircle = $SpawnArea/CollisionShape2D
onready var timer = $SpawnDelay
onready var rootNode = get_node("/root/World")
onready var Enemy = preload("res://Scenes/Actors/Enemy.tscn")

var canSpawn := true

func _ready():
	randomize()

#func _input(event):
#	var pressed = event.is_pressed() && !event.is_echo()
#	if Input.is_key_pressed(KEY_SPACE) && pressed:
#		spawn()

# returns random point inside circle in global coordinates
func getRandPosiiton() -> Vector2:
	var a = randf() * 2 * PI
	var r = spawnCircle.shape.radius * sqrt(randf())
	
	return Vector2(r * cos(a), r * sin(a)) + spawnCircle.global_position
	
func generateEnemy():
	var pos = getRandPosiiton()
	var new_enemy = Enemy.instance()
	new_enemy.global_position = pos
	return new_enemy

func spawn():
	var amount := randi() % (maxAmount - minAmount + 1) + minAmount
	var attempts := 0
	var done := false
	var pos := getRandPosiiton()
	var spaceState = get_world_2d().direct_space_state
	
	for i in amount:
		attempts = 0
		while attempts < 10:
			var new_enemy = generateEnemy()
			var query = Physics2DShapeQueryParameters.new()
			query.set_shape(new_enemy.get_node("Collision").shape)
			if spaceState.intersect_shape(query).size() == 0:
				rootNode.add_child(new_enemy)
				attempts = 10
			attempts += 1

func _on_Area2D_body_entered(body):
	if canSpawn:
		canSpawn = false
		timer.start()
		spawn()

func _on_SpawnDelay_timeout():
	canSpawn = true
