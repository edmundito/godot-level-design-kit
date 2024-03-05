extends Node

signal collected_item(node: Node)
signal coin_collected(coins: int)
signal show_message(message: String)
signal completed_goal()
signal level_ready(level: Level)

var level: Level : set = set_level
var player: Player
var coins := 0

func set_level(l: Level) -> void:
	level = l
	level_ready.emit(level)
	
func _load_main_scene() -> void:
	var main_scene: Node3D = load("res://addons/platform_level_design_kit/plugin/scenes/engine/main.tscn").instantiate()
	add_child(main_scene)

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_main_scene()
	collected_item.connect(_on_collected_item)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_collected_item(item: Node) -> void:
	if item.is_in_group("coin"):
		coins += 1
		coin_collected.emit(coins)
