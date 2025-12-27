@abstract
class_name MathUtils extends Object

static func sum(a:Array) -> Variant:
	if a.is_empty():
		return null
	var result = a[0]
	for i in a.size()-1:
		result += a[i+1]
	return result
