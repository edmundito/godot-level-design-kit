class_name Checkpoint
extends Area3D

var checked := false


# Called when the node enters the scene tree for the first time.
func _ready():
	E.level_ready.connect(_on_level_ready)

func _on_level_ready(level: Level) -> void:
	if level.is_3d_navigation():
		($flag as Node3D).rotation = Vector3(0, 0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body: Node3D):
	if checked or not body.is_in_group('player'):
		return
		
	($CollisionShape3D as CollisionShape3D).disabled = true
	Audio.play("res://assets/sound_fx/coin.ogg")
	var tween := get_tree().create_tween()
	tween.tween_property($flag, "scale", Vector3(), 0.4)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_callback($flag.queue_free)
	tween.play()
	checked = true
	E.entered_checkpoint.emit(self)
