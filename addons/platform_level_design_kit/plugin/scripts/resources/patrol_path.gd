class_name PatrolPath
extends Resource

enum PatrolPathDirection {
	## Do nothing
	NONE,
	## Move in the positive side of the axis
	POSITIVE,
	## Move in the negative side of the axis
	NEGATIVE
}

## Amount. Distance in units OR when X and Z diretion is set to "None", waits for [amount] seconds.
@export var amount: float
## Changes the X Direction
@export var x_direction: PatrolPathDirection
## FOR 3D LEVELS ONLY: Changes the Z Direction
@export var z_direction: PatrolPathDirection

func has_direction() -> bool:
	return x_direction != PatrolPathDirection.NONE or z_direction != PatrolPathDirection.NONE

func get_direction_vector3() -> Vector3:
	var x: int
	var z: int
	
	if x_direction == PatrolPathDirection.NEGATIVE:
		x = -1
	elif x_direction == PatrolPathDirection.POSITIVE:
		x = 1
	
	if z_direction == PatrolPathDirection.NEGATIVE:
		z = -1
	elif z_direction == PatrolPathDirection.POSITIVE:
		z = 1
		
	return Vector3(x, 0, z)
