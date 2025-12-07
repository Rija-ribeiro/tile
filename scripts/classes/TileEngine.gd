## Un TileEngine permet de stocker et mettre à jour les tuiles que l-on lui fournit.
class_name TileEngine extends Resource
var tiles:Array[Tile]

## revoie la tuile occupant la position donnée
func search_from_pos(pos:Vector2i) -> Tile:
	for tile in tiles:
		if tile.rect.has_point(pos):
			return tile
	return null

## renvoie les tuiles touchant le rectangle donné
## utile pour selectionner les tuiles ou pour savoir si une tuile peut être à un emplacement
func search_from_rec(rec:Rect2i) -> Array[Tile]:
	var result:Array[Tile]
	for tile in tiles:
		if tile.rect.intersects(rec):
			result.append(tile)
	return result

## retourne si une tuile de ce type peut ou non être placé à cette position.
func can_add(def:TileDef, pos:Vector2i) -> bool:
	return search_from_rec(Rect2i(pos, def.size)).is_empty()

## essay d'ajouter la tuile et renvoie une erreur si celle si manque de place.
func add(tile:Tile) -> Error:
	if can_add(tile.def, tile.pos):
		tiles.append(tile)
		return OK
	return FAILED
