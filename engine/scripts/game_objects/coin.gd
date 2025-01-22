extends Area3D

var time := 0.0
var grabbed := false

func _ready() -> void:
	if get_node("Particles") != null:
		$Particles.visible = G.config.particles_enabled
		$Particles.emitting = false

# Collecting coins

func _on_body_entered(body):
	if body.has_method("collect_coin") and !grabbed:
		
		body.collect_coin()
		
		Audio.play("res://assets/sound_fx/coin.ogg") # Play sound
		
		$Mesh.queue_free() # Make invisible
		$Particles.emitting = false # Stop emitting stars
		
		grabbed = true

# Rotating, animating up and down

func _process(delta):
	
	rotate_y(2 * delta) # Rotation
	position.y += (cos(time * 5) * 1) * delta # Sine movement
	
	time += delta
