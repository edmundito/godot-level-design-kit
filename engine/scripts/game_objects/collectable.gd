class_name Collectable
extends Area3D

@export var spin_speed := 2
@export var bounce_speed := 5

var time := 0.0
var grabbed := false

func _ready() -> void:
	if get_node("Particles") != null:
		$Particles.visible = G.config.particles_enabled
		$Particles.emitting = false

func _on_body_entered(body: Node3D) -> void:
	if grabbed or not body.is_in_group("player"):
		return
		
	grabbed = true
	E.collected_item.emit(self)
		
	Audio.play("res://assets/sound_fx/coin.ogg") # Play sound
	queue_free()

func _process(delta: float) -> void:
	if spin_speed > 0:
		rotate_y(spin_speed * delta) # Rotation
		
	if bounce_speed > 0:
		position.y += (cos(time * bounce_speed) * 1) * delta # Sine movement
		time += delta
