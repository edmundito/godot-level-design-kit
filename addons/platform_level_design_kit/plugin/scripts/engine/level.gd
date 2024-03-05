class_name Level
extends Node3D

enum NavigationType { TWO_DIMENSIONAL, THREE_DIMENSIONAL }

@export var navigation_type: NavigationType = NavigationType.THREE_DIMENSIONAL
@export var gravity: float = 25

func is_3d_navigation() -> bool:
	return navigation_type == NavigationType.THREE_DIMENSIONAL
	
# Called when the node enters the scene tree for the first time.
func _ready():
	E.level = self
	position = Vector3(0, 0, 0)
	rotation = Vector3(0, 0, 0)
	
	# Enable collisions in CSGs
	for child in get_children():
		if child is CSGCombiner3D:
			(child as CSGCombiner3D).use_collision = true

# Called every frame. 'delta' is the elapsed time since the previouws frame.
func _process(delta):
	pass
