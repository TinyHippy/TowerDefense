extends Area2D


export var health = 100
export var armor = 0
export var speed = 150
export var path = "GroundPath"
export var spawnInterval = 5.0
export var worth = 1


var move_direction = 0
onready var path_follow = get_parent()
onready var pathDistance = path_follow.get_parent().curve.get_baked_length()
onready var completed = (path_follow.get_offset())/(pathDistance)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = str(health)
	
	
func _physics_process(delta):
	movement(delta)
	
func _process(_delta):
	if(health <= 0):
		queue_free()
		$"/root/Global".money += worth

func movement(delta):
	var prePos = path_follow.get_global_position() #save previous position for angle calc
	path_follow.set_offset(path_follow.get_offset() +speed*delta) #set the new offset (how far into path) by getting its current offset and setting its new one
	var pos = path_follow.get_global_position()
	completed = (path_follow.get_offset())/(pathDistance)
	$Label.text = str(health)
	move_direction = (pos.angle_to_point(prePos))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
