extends Sprite

func _ready():
	get_node("../").connect("MW_up", self, "_cursorU_roll")
	get_node("../").connect("MW_down", self, "_cursorD_roll")
	_refresh()

func _refresh():
	var curTile = get_node("../../").curTile
	set_texture(get_node("../../").get_tileset().tile_get_texture(curTile))

func _cursorU_roll():
	_refresh()

func _cursorD_roll():
	_refresh()