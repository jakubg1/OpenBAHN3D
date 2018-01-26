extends HBoxContainer

func _ready():
	
	System.connect("refresh_texts", self, "_txt_refresh")
	System.set_language("en")
	
	System.connect("LMB_pressed", self, "_cursorL_pressed")
	
	# creating menu items; some useful items:
	# [[], -1, [[0]]] = separator
	var menu_entries = []
	
	_create_menu_item("Test", [
	[["LanguageEN"], 0, [[1, "en"]]],
	[["LanguagePL"], 0, [[1, "pl"]]],
	[["UI_MENU_OPTIONS", " dupa!"], 1, [[0]]],
	[[], -1, [[0]]]
	])
	
	_create_menu_item("UI_MENU_FILE", [
	[["UI_MENU_FILE_NEW"], 0, [[0]]],
	[["UI_MENU_FILE_OPEN"], 0, [[0]]],
	[["UI_MENU_FILE_SAVE"], 0, [[0]]],
	[["UI_MENU_FILE_SAVE_AS"], 0, [[0]]],
	[[], -1, [[0]]],
	[["UI_MENU_FILE_RECENT"], 0, [[0]]]
	])
	
	_create_menu_item("UI_MENU_TIME", [
	[["TIME"], 0, [[0]]],
	[[], -1, [[0]]],
	[["UI_MENU_TIME_PAUSE"], 1, [[2, true], [2, false]]]
	])
	
	_create_menu_item("UI_MENU_OPTIONS", [
	[["Null"], 0, [[0]]]
	])
	
	var locale_list = ["en", "pl", "pt"] # to change
	for i in range(locale_list.size()):
		var local = locale_list[i]
		menu_entries.append([[System.tr("UI_MENU_LANGUAGE_" + local.to_upper()) + " (" + System.trl("UI_MENU_LANGUAGE_" + local.to_upper(), local) + ")"], 1, [[1, local]]])
	
	_create_menu_item("UI_MENU_LANGUAGE",
	menu_entries
	)

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
	#for i in range(TranslationServer.
	# in the future, the list of the languages should be generated dynamically
	get_node("ButtonLanguage/MenuLanguage").set_item_text(0, System.tr("UI_MENU_LANGUAGE_EN") + " (" + System.trl("UI_MENU_LANGUAGE_EN", "en") + ")")
	get_node("ButtonLanguage/MenuLanguage").set_item_text(1, System.tr("UI_MENU_LANGUAGE_PL") + " (" + System.trl("UI_MENU_LANGUAGE_PL", "pl") + ")")
	get_node("ButtonLanguage/MenuLanguage").set_item_text(2, System.tr("UI_MENU_LANGUAGE_PT") + " (" + System.trl("UI_MENU_LANGUAGE_PT", "pt") + ")")

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
	if id == 2:
		System.set_language("pt")

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
	get_node("Button/Menu").hide()

var menu_item_node = preload("res://UI_MenuBar/MenuBarButton.tscn")

func _create_menu_item(name, items):
	
	var menu_item = menu_item_node.instance()
	menu_item._set_text(name)
	menu_item._set_items(items)
	add_child(menu_item)
