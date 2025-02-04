class_name PatrolPath2Config extends Resource

@export var speed := 1.0
## The path that the Enemy will patrol.
@export_custom(PROPERTY_HINT_ARRAY_TYPE, "PatrolPath2", PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_ALWAYS_DUPLICATE)
var paths: Array[PatrolPath2] = []
## Enables path logging in Output panel.
@export var log_path_changes := false
