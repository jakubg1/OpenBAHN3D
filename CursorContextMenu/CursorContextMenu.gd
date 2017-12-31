extends PopupMenu

func _ready():
	
	System.connect("refresh_texts", self, "_txt_refresh")
	
	System.connect("LMB_pressed", self, "_cursorL_pressed")
	System.connect("RMB_pressed", self, "_cursorR_pressed")
	set_process(true)

func _txt_refresh():
	
	set_item_text(0, System.tr("UI_CONTEXT_REMOVE"))

func _process(delta):
	
	System.Cursor.isEnabled = not is_visible()

func _showMenu(pos):
	
	set_pos(pos)
	show()

func _hideMenu():
	
	hide()

func _cursorL_pressed():
	
	_hideMenu()

func _cursorR_pressed():
	
	_showMenu(System.Cursor.pxpos + System.Cursor.size)

func _item_pressed(id):
	
	if id == 0:
		System.Map._rem_tile(System.Cursor.pos)
