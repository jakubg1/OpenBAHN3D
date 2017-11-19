extends Sprite
const size = Vector2(40, 20)
var pos = Vector2(0, 0)

func _ready():
	set_process(true)
	set_process_unhandled_input(true)

func _enter_tree():
	add_user_signal("LMB_pressed")
	add_user_signal("MW_up")
	add_user_signal("MW_down")

func _process(delta):
	pos = ((get_global_mouse_pos() / size).floor())
	set_pos(pos * size)

func _unhandled_input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			emit_signal("LMB_pressed", pos)
		if event.button_index == BUTTON_WHEEL_UP and event.is_pressed():
			emit_signal("MW_up")
		if event.button_index == BUTTON_WHEEL_DOWN and event.is_pressed():
			emit_signal("MW_down")