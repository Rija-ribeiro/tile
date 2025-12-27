@tool
## Classe générique pour définire un type de tuile quelquonque
## ex: usine, mine, convoyeur...
class_name TileDef extends Resource

## Le nom du type de tuile
@export var name:String
## Image de représentation de la tuile
@export var texture:Texture
## La taille de la tuile (en tuile)
@export var size:Vector2i:
	set(value):
		size = value
		perimeter = 2*value.x+2*value.y
## Le périmètre du rectangle qu'occupe la tuile
@export_storage var perimeter:int


## Surcharger cette fonction pour définire si la tuile accepte ou regette la
## GameResource qui lui est proposé.
@warning_ignore("unused_parameter")
func accept(res:GameResource, tile:Tile, from:Tile) -> bool: return false

## Surcharger cette méthode pour définire le comportement de la tuile à chaque
## update de son TileEngine.
@warning_ignore("unused_parameter")
func update(tile:Tile) -> void: pass
