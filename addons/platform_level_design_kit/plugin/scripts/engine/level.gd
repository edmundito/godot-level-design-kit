class_name Level
extends Node3D

enum NavigationType { TWO_DIMENSIONAL, THREE_DIMENSIONAL }

@export var navigation_type: NavigationType = NavigationType.THREE_DIMENSIONAL
@export var gravity: float = 25

var spawn_position: Vector3
var spawn_rotation: Vector3

func is_3d_navigation() -> bool:
	return navigation_type == NavigationType.THREE_DIMENSIONAL
	
# Called when the node enters the scene tree for the first time.
func _ready():
	E.level = self
	position = Vector3(0, 0, 0)
	rotation = Vector3(0, 0, 0)
	
	spawn_position = Vector3($Player.position)
	spawn_position = Vector3($Player.rotation)
	
	# Enable collisions in CSGs
	for child in get_children():
		if child is CSGCombiner3D:
			(child as CSGCombiner3D).use_collision = true
			
	E.entered_checkpoint.connect(_on_entered_checkpoint)

# Called every frame. 'delta' is the elapsed time since the previouws frame.
func _process(delta):
	pass

func _on_entered_checkpoint(checkpoint: Checkpoint) -> void:
	spawn_position = Vector3(checkpoint.position)
	spawn_rotation = Vector3(checkpoint.rotation)
