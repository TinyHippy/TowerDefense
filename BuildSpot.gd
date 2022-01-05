extends Node

onready var global = get_node("/root/Global")



# Called when the node enters the scene tree for the first time.
func _ready():
	hideAll()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func hideAll():
	$TowerABuild.hide()
	$TowerBBuild.hide()
	$TowerCBuild.hide()
	$TowerDBuild.hide()
	$TowerEBuild.hide()
	$TowerFBuild.hide()


func showAll():
	$TowerABuild.show()
	$TowerBBuild.show()
	$TowerCBuild.show()
	$TowerDBuild.show()
	$TowerEBuild.show()
	$TowerFBuild.show()

func _on_TextureButton_pressed():
	
	if global.building == false:
		$HideTimer.start()
		showAll()
		global.building = true


# Hides opened 'radial' when timer times out
func _on_HideTimer_timeout():
	hideAll()
	$HideTimer.stop()
	global.building = false


func _on_TowerABuild_pressed():
	var scene  = global.towerScenes["TowerA"]
	var towerInst = scene.instance()
	$Centre.add_child(towerInst)
	global.building = false
	hideAll()


func _on_TowerBBuild_pressed():
	pass
#	var scene  = Global.towerScenes["TowerB"]
#	var enemyInst = scene.instance()
#	$Centre.add_child(enemyInst)


func _on_TowerCBuild_pressed():
	pass
#	var scene  = Global.towerScenes["TowerB"]
#	var enemyInst = scene.instance()
#	$Centre.add_child(enemyInst)


func _on_TowerDBuild_pressed():
	pass
#	var scene  = Global.towerScenes["TowerB"]
#	var enemyInst = scene.instance()
#	$Centre.add_child(enemyInst)


func _on_TowerEBuild_pressed():
	pass
#	var scene  = Global.towerScenes["TowerB"]
#	var enemyInst = scene.instance()
#	$Centre.add_child(enemyInst)


func _on_TowerFBuild_pressed():
	pass
#	var scene  = Global.towerScenes["TowerB"]
#	var enemyInst = scene.instance()
#	$Centre.add_child(enemyInst)
