extends TileMap

var time = [0, 0, 0, 0] # first: day of the week (0-6), second: hour, third: minute, fourth: second
var timeDelay = 0
var simSpeed = 1 # lagging starts from 15000
var pause = false
var fps = 0
var tiles = {}
var cameraPos = Vector2(0, 0)
var cameraSize = Vector2(26, 30)
var curTile = 0

enum {UP, LEFT, DOWN, RIGHT}

signal new_second

func _ready():
	
	System.connect("LMB_pressed", self, "_cursorL_pressed")
	System.connect("MW_up", self, "_cursorU_roll")
	System.connect("MW_down", self, "_cursorD_roll")
	set_process(true)
	set_process_unhandled_input(true)
	_refresh()

func _process(delta):
	
	# FPS counting
	fps = 1 / delta
	#print("FPS: " + str(fps))
	
	if not pause:
		# time management
		var simTimeElapsed = delta * simSpeed
		timeDelay += simTimeElapsed
		while timeDelay >= 1:
			_new_second()
			timeDelay -= 1
		
		# simulator loop (train physics calculating etc.)
		pass

func _unhandled_input(event):
	
	if event.type == InputEvent.KEY:
		if event.scancode == KEY_UP and event.is_pressed():
			_move_cam_step(UP)
		if event.scancode == KEY_LEFT and event.is_pressed():
			_move_cam_step(LEFT)
		if event.scancode == KEY_DOWN and event.is_pressed():
			_move_cam_step(DOWN)
		if event.scancode == KEY_RIGHT and event.is_pressed():
			_move_cam_step(RIGHT)

func _refresh():
	
	clear()
	cameraSize = OS.get_window_size() / System.Cursor.size
	if tiles.size() > 0:
		for tile in tiles.keys():
			var pos = Vector2(tile.split(" ")[0], tile.split(" ")[1]) - cameraPos
			if pos >= Vector2(0, 0)\
					and pos < cameraSize\
					and tiles[tile].size():
				set_cell(pos[0], pos[1], tiles[tile][0])

func _move_cam(offset):
	
	cameraPos += offset
	_refresh()

func _move_cam_step(dir):
	
	if dir == UP:
		_move_cam(Vector2(0, -1))
	elif dir == LEFT:
		_move_cam(Vector2(-1, 0))
	elif dir == DOWN:
		_move_cam(Vector2(0, 1))
	elif dir == RIGHT:
		_move_cam(Vector2(1, 0))

func _set_tile(pos, id, params):
	
	if id == 0:
		_rem_tile(pos)
	else:
		tiles[get_tile_name(pos + cameraPos)] = [id]
		_refresh()

func _rem_tile(pos):
	
	tiles.erase(get_tile_name(pos + cameraPos))
	_refresh()

func _clear_world():
	
	tiles = {}
	_refresh()

func _new_second():
	
	time[3] += 1
	if time[3] == 60: # new minute
		time[2] += 1
		time[3] = 0
	if time[2] == 60: # new hour
		time[1] += 1
		time[2] = 0
	if time[1] == 24: # new day
		time[0] += 1
		time[1] = 0
	if time[0] == 7: # new week
		time[0] = 0
	emit_signal("new_second")

func _cursorL_pressed():
	
	if System.Cursor.isEnabled:
		_set_tile(System.Cursor.pos, curTile, [])

func _cursorU_roll():
	
	curTile += 1

func _cursorD_roll():
	
	if curTile > 0:
		curTile -= 1

static func get_tile_name(pos):
	
	return str(pos[0])\
		+ " "\
		+ str(pos[1])
