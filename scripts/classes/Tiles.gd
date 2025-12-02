## Classe générique pour définire un type de tuile quelquonque
## ex: usine, mine, convoyeur...
class_name Tile extends Resource

## le nom du type de tuile
@export var name:String
## image de représentation de la tuile
@export var texture:Texture
## La position de la tuile (en tuile)
@export var pos:Vector2i
## Les dimentions de la tuile (en tuile)
@export var size:Vector2i = Vector2i(1, 1)
## Le stokage maximal de la tuile
@export var max_storage:Dictionary[GameResource, int]
## Le stokage actuel de la tuile
var storage:Dictionary[GameResource, int]
