extends Button

onready var menu_node = get_node("Menu")

var text_source = ""
var actions = []

func _ready():
	
	var pos = get_pos()
	menu_node.set_pos(Vector2(pos[0], pos[1] + 24))

func _set_text(text):
	
	text_source = text
	_update_text()

func _update_text():
	
	set_text(System.tr(text_source))

func _set_items(items):
	var menu_node = get_node("Menu")
	#menu_node.remove_item(0) # to change, we want to remove all items here
	actions = [] # we're doing the same with the action array
	# item syntax:
	# the "items" variable is an array with some items, each item is one menu item
	# that item is another array containing data about it
	# items:
		# 0 - array of strings (words), note, they can be translate sources, some special strings:
			# ....
		# 1 - whether the item should be:
			# -1 = separator
			# 0 = normal
			# 1 = checkable
		# 2 - an actions array:
			# 0 - an action when selected or checked and 1 - when unchecked (array):
				# 0 - action type and 1 - parameters, they can be:
					# 0 = nothing
					# 1 = change language (parameters: string-locale)
				# the action is performed when every time when it's selected (checkable item also sends if the item was checked or unchecked)
	for i in range(items.size()):
		var item = items[i]
		var final_string = ""
		for j in range(item[0].size()):
			final_string += System.tr(item[0][j])
		menu_node.add_item(final_string)
		if item[1] == -1:
			menu_node.set_item_as_separator(i, true)
		if item[1] == 1:
			menu_node.set_item_as_checkable(i, true)
		# disabling when no function
		if item[2][0][0] == 0:
			menu_node.set_item_disabled(i, true)
		actions.append(item[2])

func _on_Button_pressed():
	
	get_node("../")._hide_all()
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
	# the code below is for checking/unchecking checkable item
	# we need to add a condition because we can check uncheckable item, and when we will use it second time it will crash (nonexistent second action)
	if menu_node.is_item_checkable(id):
		menu_node.set_item_checked(id, not menu_node.is_item_checked(id))
