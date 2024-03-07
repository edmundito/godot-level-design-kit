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
@export var amount: float = 0
## Changes the X Direction
@export var x_direction: PatrolPathDirection = PatrolPathDirection.NONE
## Changes the Y Direction
@export var y_direction: PatrolPathDirection = PatrolPathDirection.NONE
## Changes the Z Direction
@export var z_direction: PatrolPathDirection = PatrolPathDirection.NONE

func has_direction() -> bool:
	return x_direction != PatrolPathDirection.NONE or \
		y_direction != PatrolPathDirection.NONE or \
		z_direction != PatrolPathDirection.NONE

func get_direction_vector3() -> Vector3:
	var vec: Vector3
	
	if x_direction == PatrolPathDirection.NEGATIVE:
		vec.x = -1
	elif x_direction == PatrolPathDirection.POSITIVE:
		vec.x = 1
		
	if y_direction == PatrolPathDirection.NEGATIVE:
		vec.y = -1
	elif y_direction == PatrolPathDirection.POSITIVE:
		vec.y = 1
	
	if z_direction == PatrolPathDirection.NEGATIVE:
		vec.z = -1
	elif z_direction == PatrolPathDirection.POSITIVE:
		vec.z = 1
		
	return vec
