extends Node

var global



#Time Variables
var time = 0
var timeLabel = 0
var nextWave = 5
var spawnTime = 0
var building = false

#Level Variables
var nextLevelName = Global.getLevel()
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
	global = get_node("/root/Global")
	

	print(global.currentLevel)
	loadLevel(nextLevelName)
	startLevel()



func _process(delta):
	waveSpawner(delta)


func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		var options = load("res://Options.tscn").instance()
		get_tree().current_scene.add_child(options)
		

func loadLevel(levelName):
	
	var scene = ResourceLoader.load("res://"+levelName+".tscn")
	level = scene.instance()
	add_child(level)
	move_child(level,0)
	
	# Load wave data
	var jsonFile = File.new()
	jsonFile.open("res://"+ levelName + "-waves.json", File.READ)
	var text = jsonFile.get_as_text()	
	var d = parse_json(text)
	if !(d):
		print("Failed to parse wave json file")
	waves = d["waves"]
	initWave(0)
	set_process(true)
	set_process_input(true)


func startLevel():
	$"/root/Global".playerHealth = 100
	$LevelTimer.start()
	$WaveTimer.start()
	$HUD/Health.text = str($"/root/Global".playerHealth)

func _on_LevelTimer_timeout():
	timeLabel += 1
	$HUD/LevelTimer.text = str(timeLabel)


func _on_WaveTimer_timeout():
	
	if(nextWave == 0):
		nextWave = 30
	else: 
		nextWave -= 1
	$HUD/NextWave/WaveTime.text = str(int(nextWave))
	

func initWave(index):
	waveIndex = index
	wave = waves[index]
	wave["count"] = wave["enemies"].size()
	wave["state"] = WAIT
	wave["index"] = 0

	#print(wave["interval"])
	
	
func startWave():
	wave["state"] = ACTIVE
	var enemy = wave["enemies"][wave["index"]]
	var scene  = global.enemyScenes[enemy["type"]]
	var enemyInst = scene.instance()
	spawnTime = time + enemyInst.spawnInterval
	


func waveSpawner(delta):
	time += delta
	#print(time)
	#print(nextWave)
	#print(spawnTime)
	if wave["state"] == ACTIVE:
		#print("ACTIVE WAVE")
		if time > spawnTime:
			var enemy = wave["enemies"][wave["index"]]
			var scene  = global.enemyScenes[enemy["type"]]
			var enemyInst = scene.instance()
			var path = PathFollow2D.new()

			path.set_loop(false)
			var pathName = enemyInst.path
			#var pathDistance = level.get_node(pathName).curve.get_baked_length()
			#print (pathName)
			level.get_node("BuildTiles").get_node(pathName).add_child(path)
			path.add_child(enemyInst)
			if(wave["index"]+1) < wave["count"]:
				wave["index"] += 1
				spawnTime = time + enemyInst.spawnInterval
			else:
				wave["state"] = FINISHED
				if(waveIndex+1) < waves.size():
					initWave(waveIndex+1)
	elif wave["state"] == WAIT:
		#print("WAIT WAVE")
		
		if nextWave > 0:
			pass
		else:
			startWave()
	



