extends Node

#var enemyData = preload("res://enemy/enemy.gd")
@export var enemyScene: PackedScene
var score: int = 0


func new_game(): 
	score = 0
	$Music.play()
	
func game_over():
	$Music.stop()

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


func _on_spawnTimer_timeout():
	#var enemy_spawn = randi_range(0, enemyList)
	var enemy = enemyScene.instantiate()
	enemy.position = $spawnLocation.position
	add_child(enemy)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
