## Classe générique pour définire un type de tuile quelquonque
## ex: usine, mine, convoyeur...
class_name TileDef extends Resource

## le nom du type de tuile
@export var name:String
## image de représentation de la tuile
@export var texture:Texture
## La taille de la tuile (en tuile)
@export var size:Vector2i
## Le stokage maximal de la tuile
@export var max_storage:Dictionary[GameResource, int]
