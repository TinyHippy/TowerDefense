extends Node

var playerHealth = 99
var time = 0
var nextWave = 30

export (PackedScene) var Enemy

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("ASSSSS")
	startLevel()

#	var enemy = Enemy.instance()
#	$LevelOne/EnemyPath/EnemySpawn.add_child(enemy)
	
#	var dir = $LevelOne/EnemyPath/EnemySpawn
#	enemy.position = $LevelOne/EnemyPath/EnemySpawn.position
#	enemy.linear_velocity = $LevelOne/EnemyPath

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func startLevel():
	playerHealth = 100
	$LevelTimer.start()
	$WaveTimer.start()
	$HUD/Health.text = str(playerHealth)

func _on_LevelTimer_timeout():
	time += 1
	$HUD/LevelTimer.text = str(time)


func _on_WaveTimer_timeout():
	nextWave -= 1
	$HUD/NextWave/WaveTime.text = str(nextWave)
