extends Button

onready var menu_node = get_node("Menu")

var text_source = ""
var item_text_source = []
var actions = []
var refreshing_conditions = []

func _ready():
	
	System.connect("refresh_texts", self, "_txt_refresh")
	System.Map.connect("new_second", self, "_second_refresh")
	get_node("../").connect("menubar_hide_context", self, "_hide")
	
	var pos = get_pos()
	menu_node.set_pos(Vector2(pos[0], pos[1] + 24))

func _txt_refresh():
	
	_update_text()
	_update_items()

func _second_refresh():
	
	_update_items("time")

func _set_text(text):
	
	text_source = text
	_update_text()

func _update_text():
	
	set_text(System.tr(text_source))

func _set_items(items):
	
	var menu_node = get_node("Menu")
	menu_node.clear() # we're making the popup menu empty
	actions = [] # we're doing the same with the action array
	refreshing_conditions = []
	# item syntax:
	# the "items" variable is an array with some items, each item is one menu item
	# that item is another array containing data about it
	# items:
		# 0 - array of strings (words), note, they can be translate sources, some special strings:
			# TIME = outputs the current time, it's refreshed every simulation second
		# 1 - whether the item should be:
			# -1 = separator
			# 0 = normal
			# 1 = checkable
		# 2 - an actions array:
			# 0 - an action when selected or checked and 1 - when unchecked (array):
				# 0 - action type and 1 - parameters, they can be:
					# 0 = nothing
					# 1 = change language (parameters: string-locale)
					# 2 = set pause state (parameters: bool-paused)
					# 3 = open time changing window (no parameters)
					# 4 = clear the world (no parameters)
				# the action is performed when every time when it's selected (checkable item also sends if the item was checked or unchecked)
	item_text_source = []
	for i in range(items.size()):
		var item = items[i]
		item_text_source.append(item[0])
		menu_node.add_item("")
		if item[1] == -1:
			menu_node.set_item_as_separator(i, true)
		if item[1] == 1:
			menu_node.set_item_as_checkable(i, true)
		# disabling when no function
		if item[2][0][0] == 0:
			menu_node.set_item_disabled(i, true)
		actions.append(item[2])
		# additional refreshing
		for j in range(item[0].size()):
			var parsed_text = item[0][j]
			if parsed_text == "TIME":
				refreshing_conditions.append([i, "time"])
	_update_items()

func _update_item(id):
	
	var menu_node = get_node("Menu")
	var text = ""
	for i in range(item_text_source[id].size()):
		var parsed_text = item_text_source[id][i]
		if parsed_text == "TIME":
			text += _time_text()
		else:
			text += System.tr(parsed_text)
	menu_node.set_item_text(id, text)

func _update_items(d_condition = "none"):
	
	var menu_node = get_node("Menu")
	if d_condition == "none":
		for i in range(menu_node.get_item_count()):
			_update_item(i)
	else:
		for i in range(refreshing_conditions.size()):
			var condition = refreshing_conditions[i]
			if d_condition == condition[1]:
				_update_item(condition[0])

func _time_text():
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
	return text

func _on_Button_pressed():
	
	get_node("../").emit_signal("menubar_hide_context")
	menu_node.show()

func _on_Menu_item_pressed(id):
	
	# we have either one or two actions, when we select a non-checkable item or when we check an item it's 0,...
	var action_number = 0
	# when we uncheck an item, we are using the second action
	if menu_node.is_item_checked(id):
		action_number = 1
	# outputting the array to a variable
	var action = actions[id][action_number]
	# we described types of actions above, now we need to execute them
	if action[0] == 1:
		System.set_language(action[1])
	if action[0] == 2:
		System.set_pause(action[1])
	if action[0] == 4:
		System.Map._clear_world()
	# the code below is for checking/unchecking checkable item
	# we need to add a condition because we can check uncheckable item, and when we will use it second time it will crash (nonexistent second action)
	if menu_node.is_item_checkable(id):
		menu_node.set_item_checked(id, not menu_node.is_item_checked(id))

func _hide():
	
	menu_node.hide()
