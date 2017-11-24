extends HBoxContainer

func _ready():
	
	pass

func _on_ButtonFile_pressed():
	
	get_node("ButtonFile/MenuFile").show()

func _on_MenuFile_item_pressed(id):
	
	if id == 0:
		System.Map._clear_world()
