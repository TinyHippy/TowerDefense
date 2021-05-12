extends TextureButton


var built = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$TowerABuild.hide()
	$TowerBBuild.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	$HideTimer.start()
	$TowerABuild.show()
	$TowerBBuild.show()


func _on_HideTimer_timeout():
	$TowerABuild.hide()
	$TowerBBuild.hide()
	$HideTimer.stop()


func _on_TowerABuild_pressed():
	var scene  = Global.towerScenes["TowerA"]
	var enemyInst = scene.instance()
	$Centre.add_child(enemyInst)


func _on_TowerBBuild_pressed():
	pass
#	var scene  = Global.towerScenes["TowerB"]
#	var enemyInst = scene.instance()
#	$Centre.add_child(enemyInst)
