extends Sprite

const size = Vector2(40, 20)
var mpos = Vector2(0, 0)
var pos = Vector2(0, 0)
var pxpos = Vector2(0, 0)
var isEnabled = true

func _ready():
	
	set_process(true)

func _process(delta):
	
	if isEnabled:
		mpos = get_global_mouse_pos()
		pos = (mpos / size).floor()
		pxpos = pos * size
		set_pos(pxpos)
