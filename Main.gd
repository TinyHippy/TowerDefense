extends Node

var global

#Player variables
var playerHealth = 99

#Time Variables
var time = 0
var timeLabel = 0
var nextWave = 30
var spawnTime = 0


#Level Variables
var levelName = ""
var level = null

#Wave Variables and arrays
var maxEnemies = 12
var waves = [] #an array of all the different waves data 
var waveIndex = 0
var wave = {}

const WAIT = 0
const ACTIVE = 1
const FINISHED = 2

export (PackedScene) var Enemy

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(Global.test)
	global = Global
	startLevel()
	
	# Loads level if level is blank must be levelOne
	if (levelName == ""):
		levelName = "level-01"
	var scene = ResourceLoader.load("res://"+levelName+".tscn")
	level = scene.instance()
	print(level)
	add_child(level)
	move_child(level,0)
	
	# Load wave data
	var jsonFile = File.new()
	jsonFile.open("res://"+ levelName + "-waves.json", File.READ)
	var text = jsonFile.get_as_text()	
	var d = parse_json(text)
	print(d)
	if !(d):
		print("Failed to parse wave json file")
	waves = d["waves"]
	initWave(0)
	set_process(true)
	set_process_input(true)
		
	

#	var enemy = Enemy.instance()
#	$LevelOne/EnemyPath/EnemySpawn.add_child(enemy)
	
#	var dir = $LevelOne/EnemyPath/EnemySpawn
#	enemy.position = $LevelOne/EnemyPath/EnemySpawn.position
#	enemy.linear_velocity = $LevelOne/EnemyPath

	



func startLevel():
	playerHealth = 100
	$LevelTimer.start()
	$WaveTimer.start()
	$HUD/Health.text = str(playerHealth)

func _on_LevelTimer_timeout():
	timeLabel += 1
	$HUD/LevelTimer.text = str(timeLabel)


func _on_WaveTimer_timeout():
	
#	if(nextWave == 0):
#		nextWave = 30
#	else: 
#		nextWave -= 1
	$HUD/NextWave/WaveTime.text = str(int(nextWave))
	

func initWave(index):
	waveIndex = index
	wave = waves[index]
	wave["count"] = wave["enemies"].size()
	wave["state"] = WAIT
	wave["index"] = 0
	nextWave = wave["interval"]
	print(wave["interval"])
	
	
func startWave():
	wave["state"] = ACTIVE
	spawnTime = time + wave["enemies"][wave["index"]]["interval"]
	
	

func _process(delta):
	time += delta
	#print(time)
	#print(nextWave)
	if wave["state"] == ACTIVE:
		print("ACTIVE WAVE")
		if time > nextWave:
			var enemy = wave["enemies"][wave["index"]]
			var scene  = global.enemyScenes[enemy["type"]]
			var enemyInst = scene.instance()
			var path = PathFollow2D.new()
			path.set_loop(false)
			var pathName = enemy["path"]
			print (pathName)
			level.get_node(pathName).add_child(path)
			path.add_child(enemyInst)
			if(wave["index"]+1) < wave["count"]:
				wave["index"] += 1
				spawnTime = time + wave["enemies"][wave["index"]]["interval"]
			else:
				wave["state"] = FINISHED
				if(waveIndex+1) < waves.size():
					initWave(waveIndex+1)
	elif wave["state"] == WAIT:
		#print("WAIT WAVE")
		nextWave -= delta
		if nextWave > 0:
			pass
		else:
			startWave()
				
