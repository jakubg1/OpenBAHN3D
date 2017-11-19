extends Sprite

func _ready():
	set_process(true)
	pass

func _process(delta):
	var curTile = get_node("../../").curTile
	set_texture(get_node("../../").get_tileset().tile_get_texture(curTile))
	print(curTile)