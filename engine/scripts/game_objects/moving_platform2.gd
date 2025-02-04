class_name MovingPlatform2 extends StaticBody3D

@export_custom(PROPERTY_HINT_RESOURCE_TYPE, "PatrolPath2Config", PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_ALWAYS_DUPLICATE)
var patrol_path: PatrolPath2Config

var velocity := Vector3()

var _patrol_behavior: PatrolBehavior

func _ready() -> void:
	if patrol_path != null:
		_patrol_behavior = PatrolBehavior.new(
			self,
			patrol_path
		)
		add_child(_patrol_behavior)

			
func _physics_process(delta) -> void:
	if _patrol_behavior != null:
		_patrol_behavior.process()
	
	position += velocity * delta
	constant_linear_velocity = Vector3(velocity)
