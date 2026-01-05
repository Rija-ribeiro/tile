## Tile est la partie sauvegardable d'une tuile
class_name Tile extends Resource

var is_init:bool:
	set(value):
		if not warn_init("is_init"):
			is_init = value
## définition de la tuile
var def:TileDef:
	set(value):
		if not warn_init("def"):
			def = value
## position de la tuile
var pos:Vector2i:
	set(value):
		if not warn_init("pos"):
			pos = value
var rotation:int:
	set(value):
		if not warn_init("rec"):
			rotation = posmod(value, 4)
## le rectangle occupé par la tuile
var rect:Rect2i:
	set(value):
		if not warn_init("rec"):
			rect = value
	get():
		if is_init:
			return rect
		elif rotation%2:
			# si il est tourné de 90 ou -90 deg, on inverse les composantes.
			return Rect2i(pos, Vector2i(def.size.y, def.size.x))
		else:
			return Rect2i(pos, def.size)
## le TileEngine dans lequel est ajouté
var tile_engine:TileEngine:
	set(value):
		if not warn_init("tile_engine"):
			tile_engine = value
## la liste des position de toutes les tuiles voisines à celle-ci
var neighbors:Array[Tile]
## les ressources actuellements stocké dans cette tuile
var storage:Dictionary[GameResource, int]

## Utiliser cette methode pour modifier une propriété de la tuile et produire
## une erreur si elle est déjà initialisé
func warn_init(property:String) -> bool:
	if is_init:
		push_error(
			"failed to set "
			+property
			+" because this tile is already init"
		)
	return is_init

## initialisation générale de la tuile
func _enter_engine() -> void:
	# on remplie la varriable rct avec la valeur fourie par sont getter.
	rect = rect
	_update_neighbor()
	for neighbor in neighbors:
		if is_instance_valid(neighbor):
			neighbor._update_neighbor()
	is_init = true

func _exit_engine() -> void:
	for tile in neighbors:
		if is_instance_valid(tile):
			for index in tile.get_neighbor_indexs(self):
				tile.neighbors[index] = null

## cette fonction sert à reprendre connaissance des tuiles voisines. Elle est 
## utile à l'initialisation et à la création et supression des tuiles voisines.
func _update_neighbor() -> void:
	var sides:Array[Array] = [[], [], [], []] #HAUT,BAS,GAUCHE,DROITE
	for x in def.size.x:
		sides[SIDE_TOP].append(tile_engine.search_from_pos(pos+Vector2i(x, -1)))
		sides[SIDE_BOTTOM].append(tile_engine.search_from_pos(pos+Vector2i(x, def.size.y)))
	for y in def.size.y:
		sides[SIDE_LEFT].append(tile_engine.search_from_pos(pos+Vector2i(-1, y)))
		sides[SIDE_RIGHT].append(tile_engine.search_from_pos(pos+Vector2i(def.size.x, y)))
	neighbors = []
	for i in 4:
		neighbors.append_array(sides[posmod(i-rotation, 4)])

## renvoie la n-ième tuile voisine
func get_neighbor(index:int) -> Tile:
	return neighbors[posmod(index, def.perimeter)]

## renvoie l'index-voisin de la tuile. renvoie -1 si la tuile n'est pas voisine.
func get_neighbor_indexs(tile:Tile) -> Array[int]:
	var result:Array[int]
	for i in def.perimeter:
		if neighbors[i]==tile:
			result.append(i)
	return result

##
func give_to(res:GameResource, index:int) -> Error:
	var neighbor := get_neighbor(index)
	if not is_instance_valid(neighbor): return FAILED
	if not neighbor.def.accept(res, neighbor, self): return FAILED
	if storage[res] == 0: return FAILED
	neighbor.storage[res] += 1
	storage[res] -=1
	return OK
