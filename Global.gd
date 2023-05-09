extends Node

var currentLevel = null
var test = "test"
var building = false

#Player Variables
var money = 10
var playerHealth = 5

var debug = false

var enemyScenes = {}
var towerScenes = {}
var buildNode

func _ready():
	var root = get_tree().get_root()
	currentLevel = root.get_child( root.get_child_count()-1)
	print(currentLevel,root.name)
	#pre load enemies and towers
	enemyScenes["Enemy-a"] = preload("res://Enemy-a.tscn")
	enemyScenes["Enemy-b"] = preload("res://Enemy-b.tscn")
	towerScenes["TowerA"] = preload("res://TowerA.tscn")
	buildNode = preload("res://BuildSpot.tscn")
	# towerScenes["TowerB"] = preload("res://TowerB.tscn")
	
# getter and setters for vars
func changeMoney(amount):
	money += amount
	
func changeHealth(amount):
	playerHealth += amount
