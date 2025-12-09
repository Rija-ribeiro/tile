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
func get_rec() -> Rect2i: return Rect2i(pos, def.size)
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
