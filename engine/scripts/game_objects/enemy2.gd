class_name Enemy2 extends CharacterBody3D

## Units per second.
@export var speed := 1.0
## The path that the Enemy will patrol.
@export var patrol_paths: Array[PatrolPath2] = []
## Enables path logging in Output panel.
@export var log_path_changes := false

@onready var animation: AnimationPlayer = $Character/AnimationPlayer as AnimationPlayer

var rotation_direction: float = 1.5

var _patrol_behavior: PatrolBehavior

func _ready() -> void:
	_patrol_behavior = PatrolBehavior.new(
		self,
		patrol_paths,
		speed,
		log_path_changes
	)
	add_child(_patrol_behavior)
			
func _physics_process(delta) -> void:	
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
