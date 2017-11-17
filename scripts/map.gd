extends TileMap
var tiles = {}

func _ready():
	#connect("LMB_pressed", get_node("Cursor"), "_cursorL_pressed")
	get_node("Cursor").connect("LMB_pressed", self, "_cursorL_pressed")
	#_add_tile(Vector2(2, 3), 2, [])
	_refresh()

func _refresh():
	clear()
	if tiles.size() > 0:
		for tile in tiles.keys():
			print(tile)
			var pos = Vector2(tile.split(" ")[0], tile.split(" ")[1])
			set_cell(pos[0], pos[1], tiles[tile][0])

func _cursorL_pressed(pos):
	_add_tile(pos, 1, [])

func _add_tile(pos, id, params):
	tiles[str(pos[0]) + " " + str(pos[1])] = []
	tiles[str(pos[0]) + " " + str(pos[1])].append(id)
	_refresh()