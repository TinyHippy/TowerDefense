extends Control

var global
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/Global")
	global.optionOpen = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ExitOptions_pressed():
	global.optionOpen = false
	get_tree().current_scene.remove_child(self)


func _on_Button_toggled(button_pressed):
	if(button_pressed):
		$VBoxContainer/HBoxContainer/Button.text = "Off"
		Global.changeLevelName("level-01")
	else:
		$VBoxContainer/HBoxContainer/Button.text = "On"
		Global.changeLevelName("level-02")



func _on_Button2_pressed():
	get_tree().quit()
