extends Node

var currentLevel = null
var test = "test"

#Player Variables
var money = 10
var playerHealth = 5

var debug = false

var enemyScenes = {}

func _ready():
	var root = get_tree().get_root()
	currentLevel = root.get_child( root.get_child_count()-1)
	#pre load enemies
	enemyScenes["Enemy-a"] = preload("res://Enemy-a.tscn")
	enemyScenes["Enemy-b"] = preload("res://Enemy-b.tscn")


# getter and setters for vars
func changeMoney(amount):
	money += amount
	
func changeHealth(amount):
	playerHealth += amount
