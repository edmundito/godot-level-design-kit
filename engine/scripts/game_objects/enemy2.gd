class_name Enemy2 extends CharacterBody3D

@export_custom(PROPERTY_HINT_RESOURCE_TYPE, "PatrolPath2Config", PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_ALWAYS_DUPLICATE)
var patrol_path: PatrolPath2Config

@onready var animation: AnimationPlayer = $Character/AnimationPlayer as AnimationPlayer

var rotation_direction: float = 1.5

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

	move_and_slide()
	_check_collisions()
	
	if Vector2(velocity.z, velocity.x).length() > 0:
		rotation_direction = Vector2(velocity.z, velocity.x).angle()
		
	$Character.rotation.y = lerp_angle($Character.rotation.y, rotation_direction, delta * 10)
	
	if abs(velocity.x) > 1 or abs(velocity.z) > 1 or abs(velocity.y) or abs(velocity.z) > 1:
		animation.play("walk", 0.5)
	elif animation.has_animation("idle"):
		animation.play("idle", 0.5)

func _check_collisions() -> void:
	for index in get_slide_collision_count():
		var collision := get_slide_collision(index)
		var body := collision.get_collider()
		if body.is_in_group("player"):
			E.player_hit.emit()
			return
