extends TileMap
var tiles = {}
var curTile = 0
var cameraPos = Vector2(0, 0)
var cameraSize = Vector2(26, 30)

func _ready():
	
	System.Cursor.connect("LMB_pressed", self, "_cursorL_pressed")
	System.Cursor.connect("MW_up", self, "_cursorU_roll")
	System.Cursor.connect("MW_down", self, "_cursorD_roll")
	System.Cursor.get_node("PopupMenu").connect("menu_select", self, "_menu_select")
	set_process_unhandled_input(true)
	_refresh()

func _unhandled_input(event):
	if event.type == InputEvent.KEY:
		if event.scancode == KEY_UP and event.is_pressed():
			_move_cam_step(0)
		if event.scancode == KEY_LEFT and event.is_pressed():
			_move_cam_step(1)
		if event.scancode == KEY_DOWN and event.is_pressed():
			_move_cam_step(2)
		if event.scancode == KEY_RIGHT and event.is_pressed():
			_move_cam_step(3)

func _refresh():
	clear()
	cameraSize = OS.get_window_size() / System.Cursor.size
	if tiles.size() > 0:
		for tile in tiles.keys():
			var pos = Vector2(tile.split(" ")[0], tile.split(" ")[1]) - cameraPos
			if pos >= Vector2(0, 0) and pos < cameraSize:
				if tiles[tile].size():
					set_cell(pos[0], pos[1], tiles[tile][0])

func _move_cam(offset):
	cameraPos += offset
	_refresh()

func _move_cam_step(dir):
	if dir == 0: # up
		_move_cam(Vector2(0, -1))
	if dir == 1: # left
		_move_cam(Vector2(-1, 0))
	if dir == 2: # down
		_move_cam(Vector2(0, 1))
	if dir == 3: # right
		_move_cam(Vector2(1, 0))

func _set_tile(pos, id, params):
	if id == 0:
		_rem_tile(pos)
	else:
		tiles[str(pos[0] + cameraPos[0]) + " " + str(pos[1] + cameraPos[1])] = [id]
		_refresh()

func _rem_tile(pos):
	tiles.erase(str(pos[0] + cameraPos[0]) + " " + str(pos[1] + cameraPos[1]))
	_refresh()

func _cursorL_pressed(pos):
	_set_tile(pos, curTile, [])

func _cursorU_roll():
	curTile += 1

func _cursorD_roll():
	if curTile > 0:
		curTile -= 1

func _menu_select(id):
	if id == 0:
		_rem_tile(System.Cursor.pos)
