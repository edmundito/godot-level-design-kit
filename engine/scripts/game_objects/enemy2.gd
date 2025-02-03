class_name Enemy2 extends CharacterBody3D

## Units per second.
@export var speed := 1.0
## The path that the Enemy will patrol.
@export var patrol_paths: Array[PatrolPath2] = []
## Enables path logging in Output panel.
@export var log_path_changes := false

@onready var animation: AnimationPlayer = $Character/AnimationPlayer as AnimationPlayer
@onready var _timer: Timer = $WaitTimer as Timer

var path_index := -1
var path_start_pos: Vector3
var rotation_direction: float = 1.5

func _ready() -> void:
	if patrol_paths.size() > 0:
		_increment_path_index()
		path_start_pos = Vector3(position)
		
func _increment_path_index() -> void:
	path_index += 1
	if path_index >= patrol_paths.size():
		path_index = 0
	
	if log_path_changes:
		print("Incremented path index for \"%s\" to %d" % [self.name, path_index])
		
func _patrol_process() -> void:
	var path := patrol_paths[path_index]
	
	if not path:
		push_error("No Path found for \"%s\" in index %d", [self.name, path_index])
		_increment_path_index()
		return
		
	var move_completed = path_start_pos.distance_to(position) > path.move_units.length()

	if move_completed:
		path_start_pos = position
		velocity.x = 0
		velocity.y = 0
		velocity.z = 0

	if not path.has_direction() or move_completed and path.wait > 0.0:
		if _timer.is_stopped():
			if log_path_changes:
				print("Start %s timer for \"%d\" seconds" % [self.name, path.wait])
			_timer.start(path.wait)
		return
	
	if not _timer.is_stopped():
		return

	if move_completed:
		_increment_path_index()
		_patrol_process()
		return

	
	var direction = (transform.basis * path.get_direction_vector3()).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.y = direction.y * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0 #move_toward(velocity.x, 0, speed)
		velocity.y = 0
		velocity.z = 0 #move_toward(velocity.z, 0, speed)
			
func _physics_process(delta) -> void:	
	if path_index >= 0:
		_patrol_process()

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
	
func _on_wait_timer_timeout() -> void:
	_timer.stop()
	_increment_path_index()
