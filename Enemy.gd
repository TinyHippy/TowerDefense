extends Area2D


export var health = 100
export var armor = 0
export var speed = 150
var move_direction = 0
onready var path_follow = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	movement(delta)

func movement(delta):
	var prePos = path_follow.get_global_position() #save previous position for angle calc
	path_follow.set_offset(path_follow.get_offset() +speed*delta) #set the new offset (how far into path) by getting its current offset and setting its new one
	var pos = path_follow.get_global_position()
	move_direction = (pos.angle_to_point(prePos))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
