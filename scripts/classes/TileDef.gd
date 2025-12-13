@tool
## Classe générique pour définire un type de tuile quelquonque
## ex: usine, mine, convoyeur...
class_name TileDef extends Resource

## le nom du type de tuile
@export var name:String
## image de représentation de la tuile
@export var texture:Texture
## La taille de la tuile (en tuile)
@export var size:Vector2i:
	set(value):
		size = value
		perimeter = 2*value.x+2*value.y
## le périmètre du rectangle qu'occupe la tuile
@export_storage var perimeter:int
## Le stokage maximal de la tuile
@export var max_storage:Dictionary[GameResource, int]

## Surcharger cette méthode pour définire le comportement de la tuile à chaque
## update de son TileEngine.
func update(tile:Tile) -> void: pass

func accept(res:GameResource, from:Tile): pass
