extends PopupMenu

func _ready():
	set_process(true)
	get_node("../").connect("LMB_pressed", self, "_cursorL_pressed")
	get_node("../").connect("RMB_pressed", self, "_cursorR_pressed")

func _enter_tree():
	add_user_signal("menu_state")
	add_user_signal("menu_select")

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