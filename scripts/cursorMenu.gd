extends PopupMenu

signal menu_state
signal menu_select

func _ready():
	set_process(true)
	System.Cursor.connect("LMB_pressed", self, "_cursorL_pressed")
	System.Cursor.connect("RMB_pressed", self, "_cursorR_pressed")

func _process(delta):
	emit_signal("menu_state", is_visible())

func _showMenu(pos):
	set_pos(pos)
	show()

func _hideMenu():
	hide()

func _cursorL_pressed(pos):
	_hideMenu()

func _cursorR_pressed(pos):
	_showMenu(pos)

func _item_pressed(id):
	emit_signal("menu_select", id)