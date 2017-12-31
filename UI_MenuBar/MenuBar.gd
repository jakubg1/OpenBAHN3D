extends HBoxContainer

func _ready():
	
	System.connect("refresh_texts", self, "_txt_refresh")
	
	System.connect("LMB_pressed", self, "_cursorL_pressed")

func _txt_refresh():
	
	get_node("ButtonFile").set_text(System.tr("UI_MENU_FILE"))
	get_node("ButtonTime").set_text(System.tr("UI_MENU_TIME"))
	get_node("ButtonOptions").set_text(System.tr("UI_MENU_OPTIONS"))
	get_node("ButtonLanguage").set_text(System.tr("UI_MENU_LANGUAGE"))
	get_node("ButtonFile/MenuFile").set_item_text(0, System.tr("UI_MENU_FILE_NEW"))
	get_node("ButtonFile/MenuFile").set_item_text(1, System.tr("UI_MENU_FILE_OPEN"))
	get_node("ButtonFile/MenuFile").set_item_text(2, System.tr("UI_MENU_FILE_SAVE"))
	get_node("ButtonFile/MenuFile").set_item_text(3, System.tr("UI_MENU_FILE_SAVE_AS"))
	get_node("ButtonFile/MenuFile").set_item_text(5, System.tr("UI_MENU_FILE_RECENT"))
	get_node("ButtonTime/MenuTime").set_item_text(2, System.tr("UI_MENU_TIME_PAUSE"))
	get_node("ButtonLanguage/MenuLanguage").set_item_text(0, System.tr("UI_MENU_LANGUAGE_EN"))
	get_node("ButtonLanguage/MenuLanguage").set_item_text(1, System.tr("UI_MENU_LANGUAGE_PL"))

func _on_ButtonFile_pressed():
	
	_hide_all()
	get_node("ButtonFile/MenuFile").show()

func _on_ButtonTime_pressed():
	
	_hide_all()
	get_node("ButtonTime/MenuTime").show()

func _on_ButtonOptions_pressed():
	
	_hide_all()
	get_node("ButtonOptions/MenuOptions").show()

func _on_ButtonLanguage_pressed():
	
	_hide_all()
	get_node("ButtonLanguage/MenuLanguage").show()

func _on_MenuFile_item_pressed(id):
	
	if id == 0:
		System.Map._clear_world()

func _on_MenuTime_item_pressed(id):
	
	if id == 2:
		System.Map.pause = not System.Map.pause
		get_node("ButtonTime/MenuTime").set_item_checked(2, System.Map.pause)

func _on_MenuOptions_item_pressed(id):
	
	pass

func _on_MenuLanguage_item_pressed(id):
	
	if id == 0:
		System.set_language("en")
	if id == 1:
		System.set_language("pl")

func _menu_time_refresh():
	
	var time = System.Map.time
	var text = ""
	text += System.tr("UI_MENU_TIME_WEEK_" + str(time[0] + 1)) + ", "
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

func _cursorL_pressed():
	
	_hide_all()

func _hide_all():
	
	get_node("ButtonFile/MenuFile").hide()
	get_node("ButtonTime/MenuTime").hide()
	get_node("ButtonOptions/MenuOptions").hide()
	get_node("ButtonLanguage/MenuLanguage").hide()
