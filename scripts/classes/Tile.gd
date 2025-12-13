## Tile est la partie sauvegardable d'une tuile
class_name Tile extends Resource

var is_init:bool:
	set(value): set_and_warn_init(&"is_int", value)
## définition de la tuile
var def:TileDef:
	set(value): set_and_warn_init(&"def", value)
## position de la tuile
var pos:Vector2i:
	set(value): set_and_warn_init(&"pos", value)
## le rectangle occupé par la tuile
var rec:Rect2i:
	set(value): set_and_warn_init(&"rec", value)
## le TileEngine dans lequel est ajouté
var tile_engine:TileEngine:
	set(value): set_and_warn_init(&"tile_engine", value)
## la liste des position de toutes les tuiles voisines à celle-ci
var neighbors:Array[Tile]
## les ressources actuellements stocké dans cette tuile
var storage:Dictionary[GameResource, int]

## Utiliser cette methode pour modifier une propriété de la tuile et produire
## une erreur si elle est déjà initialisé
func set_and_warn_init(property:StringName, value) -> void:
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
func _enter_engine() -> void:
	rec = Rect2i(pos, def.size)
	perimeter = 2*(def.size.x+def.size.x)
	
	# contient les positions de toutes les voisines (q'uelles existent ou non)
	var neighbor_pos:Array[Vector2i]
	for x in def.size.x:
		# toutes les voisines du haut
		neighbor_pos.append(pos+Vector2i(-1, x))
		# toutes les voisines du bas
		neighbor_pos.append(pos+Vector2i(def.size.y, x))
	for y in def.size.y:
		# toutes les voisines de gauche
		neighbor_pos.append(pos+Vector2i(-1, y))
		# toutes les voisines de droite
		neighbor_pos.append(pos+Vector2i(def.size.x, y))
	for position in neighbor_pos:
		var tile := tile_engine.search_from_pos(position)
		neighbors.append(tile)
		if is_instance_valid(tile):
			pass #TODO faire en sorte que cette tuile prenne connaissance de soit comme une voisine
	is_init = true


## renvoie la n-ième tuile voisine
func get_neighbor(n:int) -> Tile:
	return neighbors[posmod(n, perimeter)]

## renvoie l'index-voisin de la tuile. renvoie -1 si la tuile n'est pas voisine.
func get_neighbor_index(tile:Tile) -> int:
	return neighbors.find(tile)
