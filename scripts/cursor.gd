extends Sprite
const size = Vector2(40, 20)
var pos = Vector2(0, 0)

func _ready():
	set_process(true)
	set_process_unhandled_input(true)
	add_user_signal("LMB_pressed")
	#connect("LMB_pressed", get_parent(), "_cursorL_pressed")

func _process(delta):
	#set_pos(Vector2(round((get_global_mouse_pos()[0] - 20) / 40) * 40, round((get_global_mouse_pos()[1] - 10) / 20) * 20))
	pos = ((get_global_mouse_pos() / size).floor())
	set_pos(pos * size)

func _unhandled_input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			emit_signal("LMB_pressed", pos)
			pass