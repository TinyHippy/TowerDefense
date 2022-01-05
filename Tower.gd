extends Node2D

export var cost = 5
export var attackSpeed = 1
export var damage = 2.5
export var towerRange = 4
export var type = "A"
var target = null;
var inArea =  [];

# Called when the node enters the scene tree for the first time.
func _ready():
	$Speed.wait_time = attackSpeed
	$TowerRange/HitArea.scale = Vector2(towerRange,towerRange)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (target != null):
		$Sprite.rotation = $TowerRange.get_global_position().angle_to_point(target.get_global_position())

func _on_TowerRange_area_exited(area):
	var i = 0
	if(area.get_name() == 'Enemy'):
		if(area == target):
			inArea.remove(0)
			if(inArea.size() < 1):
				target = null
			else:
				target = inArea[0]
				while(i < inArea.size()):
					if(inArea[i].completed > target.completed):
						target = inArea[i]
					i += 1

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
	if(target != null):
		target.health -= damage
