## Classe générique pour définire les différentes ressources ou minerais à
## puiser/utiliser dans les usines...
class_name GameResource extends Resource

## le nom de la ressource
## ex:terre, plomb...
@export var name:String
## L'image de qui représente cette ressource.
@export var icon:Texture

@export_range(0, 1) var seuil:float
@export var noise:FastNoiseLite

func is_at(pos:Vector2i) -> bool:
	var f = noise.get_noise_2dv(pos)
	return f > seuil
