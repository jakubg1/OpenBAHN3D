extends HBoxContainer

var strDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

func _ready():
	
	System.Map.connect("new_second", self, "_menu_time_refresh")
	System.Cursor.connect("LMB_pressed", self, "_cursorL_pressed")

func _on_ButtonFile_pressed():
	
	_hide_all()
	get_node("ButtonFile/MenuFile").show()

func _on_ButtonTime_pressed():
	
	_hide_all()
	get_node("ButtonTime/MenuTime").show()

func _on_ButtonOptions_pressed():
	
	_hide_all()
	get_node("ButtonOptions/MenuOptions").show()

func _on_MenuFile_item_pressed(id):
	
	if id == 0:
		System.Map._clear_world()

func _on_MenuTime_item_pressed(id):
	
	if id == 2:
		System.Map.pause = not System.Map.pause
		get_node("ButtonTime/MenuTime").set_item_checked(2, System.Map.pause)

func _on_MenuOptions_item_pressed(id):
	
	pass

func _menu_time_refresh(time):
	
	var text = ""
	text += strDays[time[0]] + ", "
	if time[1] < 10:
		text += "0"
	text += str(time[1]) + ":"
	if time[2] < 10:
		text += "0"
	text += str(time[2]) + ":"
	if time[3] < 10:
		text += "0"
	text += str(time[3])
	get_node("ButtonTime/MenuTime").set_item_text(0, text)

func _cursorL_pressed(pos):
	
	_hide_all()

func _hide_all():
	
	get_node("ButtonFile/MenuFile").hide()
	get_node("ButtonTime/MenuTime").hide()
	get_node("ButtonOptions/MenuOptions").hide()
