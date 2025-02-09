class_name PatrolBehavior extends Node

var _target: PhysicsBody3D
var _config: PatrolPath2Config
var _timer: Timer

var path_index := -1
var path_start_pos: Vector3

func _init(target: PhysicsBody3D, config: PatrolPath2Config):
	_target = target
	_config = config

	_timer = Timer.new()
	_timer.connect('timeout', _on_wait_timer_timeout)
	_timer.name = 'PatrolBehaviorTimer'
	_target.add_child(_timer)

	name = 'PatrolBehavior'

func _ready() -> void:
	if _config.paths.size() > 0:
		_increment_path_index()
		path_start_pos = Vector3(_target.position)
		
func _increment_path_index() -> void:
	path_index += 1
	if path_index >= _config.paths.size():
		path_index = 0
	
	if _config.log_path_changes:
		print("Incremented path index for \"%s\" to %d" % [self.name, path_index])
		
func process() -> void:
	if path_index < 0: return

	var path := _config.paths[path_index]
	
	if not path:
		push_error("No Path found for \"%s\" in index %d", [self.name, path_index])
		_increment_path_index()
		return
		
	var move_completed = path_start_pos.distance_to(_target.position) > path.move_units.length()

	if move_completed:
		path_start_pos = _target.position
		_target.velocity.x = 0
		_target.velocity.y = 0
		_target.velocity.z = 0

	if not path.has_direction() or move_completed and path.wait > 0.0:
		if _timer.is_stopped():
			if _config.log_path_changes:
				print("Start %s timer for \"%d\" seconds" % [self.name, path.wait])
			_timer.start(path.wait)
		return
	
	if not _timer.is_stopped():
		return

	if move_completed:
		_increment_path_index()
		process()
		return

	
	var direction = (_target.transform.basis * path.get_direction_vector3()).normalized()
	if direction:
		_target.velocity.x = direction.x * _config.speed
		_target.velocity.y = direction.y * _config.speed
		_target.velocity.z = direction.z * _config.speed
	else:
		_target.velocity.x = 0 #move_toward(velocity.x, 0, speed)
		_target.velocity.y = 0
		_target.velocity.z = 0 #move_toward(velocity.z, 0, speed)


func _on_wait_timer_timeout() -> void:
	_timer.stop()
	_increment_path_index()
