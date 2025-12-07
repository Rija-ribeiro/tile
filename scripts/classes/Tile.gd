## Tile est la partie sauvegardable d'une tuile
class_name Tile extends Resource

## définition de la tuile
@export var def:TileDef
## position de la tuile
@export var pos:Vector2i
## le rectangle occupé par la tuile
var rec:Rect2i:
	get = get_rec
func get_rec() -> Rect2i: return Rect2i(pos, def.size)

var tile_engine:TileEngine
