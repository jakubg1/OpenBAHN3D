extends TileMap
var tiles = {}
var curTile = 0

func _ready():
	get_node("Cursor").connect("LMB_pressed", self, "_cursorL_pressed")
	get_node("Cursor").connect("MW_up", self, "_cursorU_roll")
	get_node("Cursor").connect("MW_down", self, "_cursorD_roll")
	_refresh()

func _refresh():
	clear()
	if tiles.size() > 0:
		for tile in tiles.keys():
			var pos = Vector2(tile.split(" ")[0], tile.split(" ")[1])
			set_cell(pos[0], pos[1], tiles[tile][0])

func _add_tile(pos, id, params):
	tiles[str(pos[0]) + " " + str(pos[1])] = []
	tiles[str(pos[0]) + " " + str(pos[1])].append(id)
	_refresh()

func _rem_tile(pos):
	tiles[str(pos[0]) + " " + str(pos[1])] = []
	_refresh()

func _cursorL_pressed(pos):
	_add_tile(pos, curTile, [])

func _cursorU_roll():
	curTile += 1

func _cursorD_roll():
	if curTile > 0:
		curTile -= 1