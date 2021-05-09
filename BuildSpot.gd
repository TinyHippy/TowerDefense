extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
