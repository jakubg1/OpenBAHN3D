extends Sprite
const size = Vector2(40, 20)
var mpos = Vector2(0, 0)
var pos = Vector2(0, 0)
var pxpos = Vector2(0, 0)
var isEnabled = true

func _ready():
	get_node("PopupMenu").connect("menu_state", self, "_menu_state")
	set_process(true)
	set_process_unhandled_input(true)

func _enter_tree():
	add_user_signal("LMB_pressed")
	add_user_signal("RMB_pressed")
	add_user_signal("MW_up")
	add_user_signal("MW_down")

func _process(delta):
	if (isEnabled):
		mpos = get_global_mouse_pos()
		pos = ((mpos / size).floor())
		pxpos = pos * size
		set_pos(pxpos)

func _menu_state(state):
	isEnabled = not state

func _unhandled_input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			emit_signal("LMB_pressed", pos)
		if event.button_index == BUTTON_RIGHT and event.is_pressed():
			emit_signal("RMB_pressed", mpos)
		if event.button_index == BUTTON_WHEEL_UP and event.is_pressed():
			emit_signal("MW_up")
		if event.button_index == BUTTON_WHEEL_DOWN and event.is_pressed():
			emit_signal("MW_down")