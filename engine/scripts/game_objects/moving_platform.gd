class_name MovingPlatform
extends StaticBody3D

@export var speed := 1.0
@export var patrol_paths: Array[PatrolPath] = []
## Enable logging in output window
@export var show_path_changes_in_log := false

@onready var _timer: Timer = $WaitTimer as Timer

var path_index := -1
var path_start_pos: Vector3
var rotation_direction: float = 1.5
var velocity := Vector3()

func _ready() -> void:
	if patrol_paths.size() > 0:
		_increment_path_index()
		path_start_pos = Vector3(position)
		
func _increment_path_index() -> void:
	path_index += 1
	if path_index >= patrol_paths.size():
		path_index = 0
	
	if show_path_changes_in_log:
		print("Incremented path index for \"%s\" to %d" % [self.name, path_index])
		
func _on_wait_timer_timeout() -> void:
	_timer.stop()
	_increment_path_index()
	
func _patrol_process() -> void:
	var path := patrol_paths[path_index]
	
	if not path:
		push_error("No Path found for \"%s\" in index %d", [self.name, path_index])
		_increment_path_index()
		return
		
	if not path.has_direction():
		if _timer.is_stopped():
			if show_path_changes_in_log:
				print("Start %s timer for \"%d\" seconds" % [self.name, path.amount])
			_timer.start(path.amount)
		return
	
	if path_start_pos.distance_to(position) > path.amount:
		path_start_pos = position
		velocity.x = 0
		velocity.y = 0
		velocity.z = 0
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
	
	position += velocity * delta
	constant_linear_velocity = Vector3(velocity)
