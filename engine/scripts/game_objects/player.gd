class_name Player
extends CharacterBody3D

const View = preload("../engine/view.gd")
var view: View

var movement_velocity: Vector3
var rotation_direction: float = 1.5
var gravity = 0

var previously_floored = false

var jump_single = true
var jump_double = true

var controls_enabled := true

@onready var start_position := Vector3(self.position)
@onready var start_rotation := Vector3(self.rotation)
@onready var particles_trail = $ParticlesTrail
@onready var sound_footsteps = $SoundFootsteps
@onready var model = $Character
@onready var animation = $Character/AnimationPlayer

# Functions

func _ready() -> void:
	E.player = self
	view = E.get_node("Main/View")
	view.target = self
	E.completed_goal.connect(_on_completed_goal)
	E.player_hit.connect(_on_player_hit)
	if get_node("ParticlesTrail") != null:
		$ParticlesTrail.visible = G.config.particles_enabled
		$ParticlesTrail.emitting = false
	
func _on_completed_goal():
	_stop_moving()
	controls_enabled = false
	pass

func _physics_process(delta):
	# Handle functions
	
	if controls_enabled:
		handle_controls(delta)
	handle_gravity(delta)
	
	handle_effects()
	
	# Movement

	var applied_velocity: Vector3
	
	applied_velocity = velocity.lerp(movement_velocity, delta * 10)
	applied_velocity.y = -gravity
	
	velocity = applied_velocity
	move_and_slide()
	
	# Rotation
	
	if Vector2(velocity.z, velocity.x).length() > 0:
		rotation_direction = Vector2(velocity.z, velocity.x).angle()
		
	rotation.y = lerp_angle(rotation.y, rotation_direction, delta * 10)
	
	# Falling/respawning
	
	if position.y < -10:
		E.player_hit.emit()
		if E.hearts > 0:
			_respawn()
		else:
			_stop_moving()
	
	# Animation for scale (jumping and landing)
		
	model.scale = model.scale.lerp(Vector3(1, 1, 1), delta * 10)
	_check_collisions()
		
	# Animation when landing
	
	if is_on_floor() and gravity > 2 and !previously_floored:
		model.scale = Vector3(1.25, 0.75, 1.25)
		Audio.play("res://assets/sound_fx/land.ogg")
	
	previously_floored = is_on_floor()
	
func _check_collisions() -> void:
	for index in get_slide_collision_count():
		var collision := get_slide_collision(index)
		var body := collision.get_collider()
		if body.is_in_group("lava"):
			E.player_hit.emit()
			return

func _stop_moving() -> void:
	movement_velocity = Vector3(0, 0, 0)
	
func _respawn() -> void:
	Audio.play("res://assets/sound_fx/fall.ogg")
	position = Vector3(E.level.spawn_position)
	rotation = Vector3(E.level.spawn_rotation)
	velocity = Vector3(0, 0, 0)
	model.scale = Vector3(1, 1, 1)
	movement_velocity = Vector3(0, 0, 0)
	rotation_direction = 1.5
	gravity = 0
	
# Handle animation(s)

func handle_effects():
	
	particles_trail.emitting = false
	sound_footsteps.stream_paused = true
	
	if is_on_floor():
		if abs(velocity.x) > 1 or abs(velocity.z) > 1:
			animation.play("walk")
			particles_trail.emitting = true
			sound_footsteps.stream_paused = false
		else:
			animation.play("idle")
	else:
		animation.play("jump")

# Handle movement input

func _handle_movement(delta):
	var input := Vector3.ZERO
	
	if E.level.is_3d_navigation():
		input.x = Input.get_axis("move_left", "move_right")
		input.z = Input.get_axis("move_forward", "move_back")
		input = input.rotated(Vector3.UP, view.rotation.y).normalized()
	else:
		input.x = Input.get_axis("move_left", "move_right")
	
	movement_velocity = input * G.config.movement_speed * delta

func _handle_jumping(delta):
	if jump_single or jump_double:
		Audio.play("res://assets/sound_fx/jump.ogg")
	
	if jump_double:
		
		gravity = -G.config.jump_strength
		
		jump_double = false
		model.scale = Vector3(0.5, 1.5, 0.5)
		
	if(jump_single): jump()
	
func handle_controls(delta):
	_handle_movement(delta)
	
	if Input.is_action_just_pressed("jump"):
		_handle_jumping(delta)


# Handle gravity

func handle_gravity(delta):
	
	gravity += E.level.gravity * delta
	
	if gravity > 0 and is_on_floor():
		
		jump_single = true
		gravity = 0

# Jumping

func jump():
	
	gravity = -G.config.jump_strength
	
	model.scale = Vector3(0.5, 1.5, 0.5)
	
	jump_single = false
	jump_double = G.config.double_jump

func _on_player_hit():
	_respawn()
