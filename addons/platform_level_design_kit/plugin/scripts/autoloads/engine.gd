extends Node

signal coin_collected(coins: int)
signal show_message(message: String)
signal completed_goal()

var level: Level
var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	var main_scene: Node3D = load("res://addons/platform_level_design_kit/plugin/scenes/engine/main.tscn").instantiate()
	add_child(main_scene)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
