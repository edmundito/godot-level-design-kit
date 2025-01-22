class_name GameConfiguration extends Resource

@export_group("Camera")
@export_range(1, 179) var field_of_view: int = 40

@export_subgroup("Zoom", "zoom_")
@export var zoom_enabled := false
@export var zoom_initial = 10
@export var zoom_minimum = 16
@export var zoom_maximum = 4
@export var zoom_speed = 10

@export_subgroup("Rotation")
@export var rotation_speed = 120

@export_group("Player")
@export var movement_speed: float = 250
@export var jump_strength: float = 7
@export var double_jump: bool = false

@export_group("Graphics")
@export var particles_enabled := false

func _init():
	pass
