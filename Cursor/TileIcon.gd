extends Sprite

func _ready():
	
	System.connect("MW_up", self, "_cursorU_roll")
	System.connect("MW_down", self, "_cursorD_roll")
	_refresh()

func _refresh():
	
	set_texture(System.Map.get_tileset().tile_get_texture(System.Map.curTile))

func _cursorU_roll():
	
	_refresh()

func _cursorD_roll():
	
	_refresh()
