## Tile est la partie sauvegardable d'une tuile
class_name Tile extends Resource

var is_init:bool:
	set(value): set_and_warn_int(&"is_int", value)
## définition de la tuile
var def:TileDef:
	set(value): set_and_warn_int(&"def", value)
## position de la tuile
var pos:Vector2i:
	set(value): set_and_warn_int(&"pos", value)
## le rectangle occupé par la tuile
var rec:Rect2i:
	set(value): set_and_warn_int(&"rec", value)
## le périmètre du rectangle qu'occupe la tuile
var perimeter:int:
	set(value): set_and_warn_int(&"perimeter", value)
## la liste des position de toutes les tuiles voisines à celle-ci
var neighbors_pos:Array[Vector2i]:
	set(value): set_and_warn_int(&"neighbors_pos", value)
## le TileEngine dans lequel est ajouté
var tile_engine:TileEngine:
	set(value): set_and_warn_int(&"tile_engine", value)
## les ressources actuellements stocké dans cette tuile
var storage:Array[GameResource]

## Utiliser cette methode pour modifier une propriété de la tuile et produire
## une erreur si elle est déjà initialisé
func set_and_warn_int(property:StringName, value):
	if is_init:
		push_error(
			"failed to set "
			+str(property)
			+" to "
			+str(value)
			+" because this tile is already init"
		)
	else:
		set(property, value)

## initialisation générale de la tuile
func _tile_init() -> void:
	rec = Rect2i(pos, def.size)
	perimeter = 2*(def.size.x+def.size.x)
	for x in def.size.x:
		# toutes les voisines du haut
		neighbors_pos.append(pos+Vector2i(-1, x))
		# toutes les voisines du bas
		neighbors_pos.append(pos+Vector2i(def.size.y, x))
	for y in def.size.y:
		# toutes les voisines de gauche
		neighbors_pos.append(pos+Vector2i(-1, y))
		# toutes les voisines de droite
		neighbors_pos.append(pos+Vector2i(def.size.x, y))
	is_init = true

## renvoie la n-ième tuile voisine
func get_neighbor(n:int) -> Tile:
	return tile_engine.search_from_pos(neighbors_pos[posmod(n, perimeter)])
