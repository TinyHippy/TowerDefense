extends TileMapLayer

const BUILDABLE = "buildable"
const BUILDABLE_TYPE = 2
const MOUSE_OVER = 5
const ACTIVE = "active"

var currMouseOver = Vector2i(0, 0)
var lastMouseOver = Vector2i(-1, -1)

var worldPos
var tilePos
var tileId
var tileName
var buildSpot
var buildInst

@onready var global = get_node("/root/Global")

func _ready():
	buildSpot = global.buildNode
	buildInst = buildSpot.instantiate()

func _input(event):
	if event is InputEventMouseButton and not global.building:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			worldPos = event.position
			tilePos = local_to_map(worldPos)
			tileId = get_cell_source_id(tilePos)

			if tileId == BUILDABLE_TYPE or tileId == MOUSE_OVER:
				var newBuild = global.buildNode.instantiate()
				add_child(newBuild)
				var cell_size = Vector2(tile_set.tile_size)
				var adjust = cell_size / Vector2(4, 2)
				newBuild.position = map_to_local(tilePos) - adjust
				newBuild.showAll()
				global.building = true

	elif event is InputEventMouseMotion:
		currMouseOver = local_to_map(event.position)

		# Ensure lastMouseOver is also Vector2i for correct comparison
		if lastMouseOver != currMouseOver:
			if get_cell_source_id(currMouseOver) == BUILDABLE_TYPE and not global.building:
				set_cell(currMouseOver, MOUSE_OVER, Vector2i(0, 0), 0)  # FIXED: Corrected argument order
				set_cell(lastMouseOver, BUILDABLE_TYPE, Vector2i(0, 0), 0)  # FIXED: Corrected argument order
				lastMouseOver = currMouseOver  # Ensure lastMouseOver is a Vector2i
