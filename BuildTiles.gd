extends TileMap

const BUILDABLE = "buildable"
const BUILDABLE_TYPE = 2
const MOUSE_OVER = 5
const ACTIVE = "active"
var currMouseOver = Vector2(0,0)
var lastMouseOver = Vector2(-1,-1)
var worldPos
var tilePos
var tileId
var tileName
var buildSpot
var buildInst
onready var global = get_node("/root/Global")


# Called when the node enters the scene tree for the first time.
func _ready():
	buildSpot = global.buildNode
	buildInst = buildSpot.instance()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	
	if event is InputEventMouseButton and global.building == false:
		if event.get_button_index() == 1:
			buildSpot = global.buildNode
			var newBuild = buildSpot.instance()
			add_child(newBuild)
			print("Node name: ", get_node("."))
			print("Mouse click/unclick at:", event.position)
			worldPos = event.position
			tilePos = world_to_map(worldPos)
			tileId = get_cellv(tilePos)
			tileName = get_node(".").get_tileset().tile_get_name(tileId)
			#checking for click on buildable tile
			if tileName == ACTIVE or tileName == BUILDABLE:
				newBuild.position = map_to_world(tilePos)-(cell_size/4) #adjust for tile size to centre
				newBuild.showAll()
				global.building = true
				print("Tile pos is: ", tilePos)
	#			print("Tile id is: ", tileId)
	#			print("Tile name is: ", tileName)
	# if the mouse moves do mouse over logic
	elif event is InputEventMouseMotion:
		currMouseOver = world_to_map(event.position)
		if currMouseOver != lastMouseOver:
			if get_cellv(currMouseOver) == BUILDABLE_TYPE and global.building == false:
				print("Mouse Motion at: ", world_to_map(event.position))
				set_cellv(currMouseOver, MOUSE_OVER)
				set_cellv(lastMouseOver, BUILDABLE_TYPE)
				lastMouseOver = currMouseOver
		## checking for mouse click

