class_name Bruit extends Object
static var resources:Array[GameResource] = [
	preload("res://resources/game_resources/copper.tres"),
]


static func whitch_at (pos:Vector2i) -> GameResource:
	for resource in resources:
		if resource.is_at(pos):
			return resource
	return null
