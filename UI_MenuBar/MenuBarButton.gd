extends Button

func _ready():
	
	pass

func _update_text(text):
	
	set_text(text)


func _on_Button_pressed():
	
	get_node("../")._hide_all()
	get_node("Menu").show()
