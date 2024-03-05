class_name ExitDoor
extends Node3D

@export var coins_required: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	var completed: bool = E.coins >= coins_required
	var message: String = "You did it!" if completed else "You need %d coins to go through the door!" % coins_required
	E.show_message.emit(message)
	if completed:
		E.completed_goal.emit()
		
