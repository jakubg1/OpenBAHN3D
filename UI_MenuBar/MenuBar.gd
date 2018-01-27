extends HBoxContainer

signal menubar_hide_context

func _ready():
	
	System.connect("refresh_texts", self, "_txt_refresh")
	System.set_language("en")
	System.connect("LMB_pressed", self, "_cursorL_pressed")
	
	# creating menu items; some useful items:
	# [[], -1, [[0]]] = separator
	
	_create_menu_item("UI_MENU_FILE", [
	[["UI_MENU_FILE_NEW"], 0, [[4]]],
	[["UI_MENU_FILE_OPEN"], 0, [[0]]],
	[["UI_MENU_FILE_SAVE"], 0, [[0]]],
	[["UI_MENU_FILE_SAVE_AS"], 0, [[0]]],
	[[], -1, [[0]]],
	[["UI_MENU_FILE_RECENT"], 0, [[0]]]
	])
	
	_create_menu_item("UI_MENU_TIME", [
	[["TIME"], 0, [[3]]],
	[[], -1, [[0]]],
	[["UI_MENU_TIME_PAUSE"], 1, [[2, true], [2, false]]]
	])
	
	_create_menu_item("UI_MENU_OPTIONS", [
	[["Null"], 0, [[0]]]
	])
	
	var menu_entries = []
	
	var locale_list = ["en", "pl", "pt"] # to change
	for i in range(locale_list.size()):
		var local = locale_list[i]
		menu_entries.append([[("UI_MENU_LANGUAGE_" + local.to_upper()), " (", System.trl("UI_MENU_LANGUAGE_" + local.to_upper(), local), ")"], 0, [[1, local]]])
	
	_create_menu_item("UI_MENU_LANGUAGE",
	menu_entries
	)

func _cursorL_pressed():
	
	_hide_all()

func _hide_all():
	
	emit_signal("menubar_hide_context")

var menu_item_node = preload("res://UI_MenuBar/MenuBarButton.tscn")

func _create_menu_item(name, items):
	
	var menu_item = menu_item_node.instance()
	menu_item._set_text(name)
	menu_item._set_items(items)
	add_child(menu_item)
