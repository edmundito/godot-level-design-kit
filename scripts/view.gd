extends Node3D

@export_group("Properties")
@export var target: Node

var camera_rotation:Vector3
var zoom = 10

@onready var camera = $Camera

func _init():
	zoom = Globals.config.zoom_initial

func _ready():
	camera_rotation = rotation_degrees # Initial rotation

func _physics_process(delta):
	
	# Set position and rotation to targets
	
	self.position = self.position.lerp(target.position, delta * 4)
	rotation_degrees = rotation_degrees.lerp(camera_rotation, delta * 6)
	
	camera.position = camera.position.lerp(Vector3(0, 0, zoom), 8 * delta)
	
	handle_input(delta)

# Handle input

func handle_input(delta):
	
	# Rotation
	
	var input := Vector3.ZERO
	
	input.y = Input.get_axis("camera_left", "camera_right")
	input.x = Input.get_axis("camera_up", "camera_down")
	
	camera_rotation += input.limit_length(1.0) * Globals.config.rotation_speed * delta
	camera_rotation.x = clamp(camera_rotation.x, -80, -10)
	
	# Zooming
	
	if Globals.config.zoom_enabled:
		zoom += Input.get_axis("zoom_in", "zoom_out") * Globals.config.zoom_speed * delta
		zoom = clamp(zoom, Globals.config.zoom_maximum, Globals.config.zoom_minimum)
