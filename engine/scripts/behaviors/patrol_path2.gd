class_name PatrolPath2 extends Resource

## Number of units to move per x, y, or z.
@export_custom(PROPERTY_HINT_NONE, "suffix: m") var move_units: Vector3

## How much to wait after done moving.
@export_range(0.0, 30.0, 0.1, "suffix:seconds") var wait = 0.0

## Does it have any direction set?
func has_direction() -> bool:
	return move_units.length() != 0

## Get the direction vector
func get_direction_vector3() -> Vector3:
	return move_units.normalized()
