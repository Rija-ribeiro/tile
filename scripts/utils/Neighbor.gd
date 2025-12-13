@abstract
class_name Neighbor extends Object

## revoie la position relative de la tuile numéro index.
static func index_to_pos(def:TileDef, index:int) -> Vector2i:
	index = posmod(index, def.perimeter)
	# rangée du haut
	if index<def.size.x:
		return Vector2i(index, -1)
	index -= def.size.x
	#rangée du bas
	if index<def.size.x:
		return Vector2i(index, def.size.y)
	index -= def.size.x
	# rangée de gauche
	if index<def.size.y:
		return Vector2i(-1, index)
	index -= def.size.y
	# rangée de droite
	return Vector2i(def.size.x, index)

static func is_side(def:TileDef, pos:Vector2i, side:Side) -> bool:
	match side:
		SIDE_LEFT:
			return (pos.x == -1 and 0<=pos.y and pos.y<def.size.y)
		SIDE_TOP:
			return (pos.y == -1 and 0<=pos.x and pos.x<def.size.x)
		SIDE_RIGHT:
			return (pos.x == def.size.x and 0<=pos.y and pos.y<def.size.y)
		_:
			return (pos.y == def.size.y and 0<=pos.x and pos.x<def.size.x)

static func pos_to_index(def:TileDef, pos:Vector2i) -> int:
	var is_sides:Array[bool]
	for i in 4:
		is_sides.append(is_side(def, pos, i))
	if is_sides.count(true) != 1: return -1
	var result := 0
	if is_sides[1]:
		return pos.x
	result += def.size.x
	
	if is_sides[3]:
		return result+pos.x
	result += def.size.x
	
	if is_sides[0]:
		return result+pos.y
	result += def.size.y

	return result+pos.y
