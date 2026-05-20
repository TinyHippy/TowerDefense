extends Area2D

@export var health = 100
@export var armor = 0
@export var speed = 150
@export var path = "GroundPath"
@export var spawnInterval = 5.0
@export var worth = 1

var move_direction = 0
var dead = false
@onready var path_follow = get_parent()
@onready var pathDistance = path_follow.get_parent().curve.get_baked_length()
@onready var completed = path_follow.progress / pathDistance

func _ready():
	$Label.text = str(health)

func _physics_process(delta):
	if not dead:
		movement(delta)

func _process(_delta):
	if not dead and health <= 0:
		dead = true
		Global.money += worth
		queue_free()

func movement(delta):
	var prePos = path_follow.global_position  # Updated
	path_follow.progress += speed * delta  # Updated
	var pos = path_follow.global_position  # Updated
	completed = path_follow.progress / pathDistance  # Updated
	$Label.text = str(health)
	move_direction = pos.angle_to(prePos)  # Updated

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
