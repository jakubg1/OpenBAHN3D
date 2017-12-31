extends Node

onready var Map = get_node("/root/Main/Map")
onready var Cursor = get_node("/root/Main/Map/Cursor")

signal refresh_texts

signal LMB_pressed
signal RMB_pressed
signal MW_up
signal MW_down

func _ready():
	
	set_process_unhandled_input(true)
	set_language("en")

func set_language(locale):
	
	TranslationServer.set_locale(locale)
	emit_signal("refresh_texts")

func tr(text):
	
	return TranslationServer.translate(text)

func _unhandled_input(event):
	
	if event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			emit_signal("LMB_pressed")
		if event.button_index == BUTTON_RIGHT and event.is_pressed():
			emit_signal("RMB_pressed")
		if event.button_index == BUTTON_WHEEL_UP and event.is_pressed():
			emit_signal("MW_up")
		if event.button_index == BUTTON_WHEEL_DOWN and event.is_pressed():
			emit_signal("MW_down")
