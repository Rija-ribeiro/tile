@tool
extends EditorScript
 
func _run() -> void:
	pass
	var tilea := Tile.new()
	var tileb := Tile.new()
	var engine = TileEngine.new()
	tilea.def = ResourceLoader.load("res://test/a.tres")
	tileb.def = ResourceLoader.load("res://test/b.tres")
	tilea.pos = Vector2i.ZERO
	assert(engine.add(tilea)==OK)
	print(tilea.neighbors)
	tileb.pos = Vector2i(2, 1)
	assert(engine.add(tileb)==FAILED)
	tileb.pos = Vector2i(3, 0)
	assert(engine.add(tileb)==OK)
	print(tilea.neighbors)
	print(tileb.neighbors)
