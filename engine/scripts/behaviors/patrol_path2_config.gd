class_name PatrolPath2Config extends Resource

@export var speed := 1.0
## The path that the object will use to patrol.
@export var paths: Array[PatrolPath2] = []
## Enables path logging in Output panel.
@export var log_path_changes := false
