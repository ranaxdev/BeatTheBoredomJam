extends Node2D

export var spawnTimer : int = 5
export var minAmount : int = 2
export var maxAmount : int = 5

onready var timer := $SpawnDelay
onready var rootNode := get_node("/root/World")
onready var spawnPoints := $SpawnPoints
onready var enemy_res := preload("res://Scenes/Actors/Enemy.tscn")
onready var singleton = get_node("/root/Singleton")

var canSpawn := true
var spawnNow := false

func _ready():
	randomize()

func _physics_process(_delta):
	if canSpawn && spawnNow:
		spawn()

func spawn():
	canSpawn = false
	spawnNow = false
	var amount := randi() % (maxAmount - minAmount + 1) + minAmount
	var points := spawnPoints.get_children()
	for i in amount:
		if points.size() == 0:
			break
		var point = randi() % points.size()
		var pos = points[point]
		#add enemy to root
		if singleton.enemyCount <= 7:
			var enemy = enemy_res.instance()
			enemy.global_position = pos.global_position
			rootNode.add_child(enemy)
			points.remove(point)
	

func _on_Area2D_body_entered(body):
	if canSpawn:
		spawnNow = true

func _on_TriggerArea_body_exited(body):
	timer.start()

func _on_SpawnDelay_timeout():
	canSpawn = true
