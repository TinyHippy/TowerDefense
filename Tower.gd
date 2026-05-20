extends Node2D

@export var cost = 5
@export var attackSpeed = 1
@export var damage = 2.5
@export var towerRange = 4
@export var type = "A"
var uR = preload("res://textures/towerA/TowAUR.png")
var uL = preload("res://textures/towerA/TowAUL.png")
var dR = preload("res://textures/towerA/TowADR.png")
var dL = preload("res://textures/towerA/TowADL.png")
var target = null;
var inArea =  [];

# Called when the node enters the scene tree for the first time.
func _ready():
	$Speed.wait_time = attackSpeed
	$TowerRange/HitArea.scale = Vector2(towerRange,towerRange)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (target != null):
		if not is_instance_valid(target):
			target = null
			return
		var angleTo = $TowerRange.get_global_position().angle_to_point(target.get_global_position())
		if angleTo > 0 and angleTo < PI/2:
			$Sprite2D.texture = uL
		elif angleTo > -PI and angleTo < -PI/2:
			$Sprite2D.texture = dR
		elif angleTo > -PI/2 and angleTo < 0:
			$Sprite2D.texture = dL
		elif angleTo > PI/2 and angleTo < PI:
			$Sprite2D.texture = uR

func _on_TowerRange_area_exited(area):
	if area.get_name() != 'Enemy':
		return
	inArea.erase(area)
	if area == target:
		target = null
		for e in inArea:
			if is_instance_valid(e) and (target == null or e.completed > target.completed):
				target = e

func _on_Area2D_area_entered(area):
	if(area.get_name() == 'Enemy'):
		var enemy = area
		var priority = area.completed
		if((target !=null && priority > target.completed)||(inArea.size() == 0)):
			inArea.push_front(enemy)
			target = enemy
		else:
			inArea.push_back(enemy)

func _on_Speed_timeout():
	if is_instance_valid(target):
		target.health -= damage
