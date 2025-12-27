## Un TileEngine permet de stocker et mettre à jour les tuiles que l-on lui fournit.
class_name TileEngine extends Resource
var tiles:Array[Tile]

## Revoie la tuile occupant la position donnée.
func search_from_pos(pos:Vector2i) -> Tile:
	for tile in tiles:
		if tile.rect.has_point(pos):
			return tile
	return null

## Renvoie les tuiles touchant le rectangle donné.
## Utile pour selectionner les tuiles ou pour savoir si une tuile peut être à un emplacement.
func search_from_rec(rec:Rect2i) -> Array[Tile]:
	var result:Array[Tile]
	for tile in tiles:
		if tile.rect.intersects(rec):
			result.append(tile)
	return result

## Retourne si une tuile de ce type peut ou non être placé à cette position.
func can_add(def:TileDef, pos:Vector2i) -> bool:
	return search_from_rec(Rect2i(pos, def.size)).is_empty()

## Essay d'ajouter la tuile et renvoie une erreur si celle si manque de place.
func add(tile:Tile) -> Error:
	if can_add(tile.def, tile.pos):
		tiles.append(tile)
		tile.tile_engine = self
		tile._enter_engine()
		return OK
	return FAILED

## détruit la tuile donée
func remove(tile:Tile) -> void:
	tile._exit_engine()
	tiles.erase(tile)

## Cette méthode permet de mettre à jour toutes les tuiles présentes dans TileEngine.
func update() -> void:
	for tile in tiles:
		tile.def._update(tile)
