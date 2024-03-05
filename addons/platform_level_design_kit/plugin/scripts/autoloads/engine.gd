extends Node

signal player_hit()
signal collected_item(node: Node)
signal coin_collected(coins: int)
signal gem_collected(gems: int)
signal heart_collected(gems: int)
signal show_message(message: String)
signal completed_goal()
signal level_ready(level: Level)

var main_scene: Node3D
var level: Level : set = set_level
var player: Player
var coins := 0
var gems := 0
var hearts := 3

func set_level(l: Level) -> void:
	level = l
	level_ready.emit(level)
	
func _load_main_scene() -> void:
	main_scene = load("res://addons/platform_level_design_kit/plugin/scenes/engine/main.tscn").instantiate()
	add_child(main_scene)
	heart_collected.emit(hearts)
	gem_collected.emit(gems)
	coin_collected.emit(coins)

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_main_scene()
	collected_item.connect(_on_collected_item)
	player_hit.connect(_on_player_hit)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_collected_item(item: Node) -> void:
	if item.is_in_group("coin"):
		coins += 1
		coin_collected.emit(coins)
	elif item.is_in_group("gem"):
		gems += 1
		gem_collected.emit(gems)
	elif item.is_in_group("heart"):
		hearts += 1
		heart_collected.emit(hearts)
		
func _on_player_hit() -> void:
	hearts -= 1
	if hearts == 0:
		_game_over()
	else:
		heart_collected.emit(hearts)
		
func _game_over() -> void:
	remove_child(level)
	remove_child(main_scene)
	var game_over_scene: Node = load("res://addons/platform_level_design_kit/game_ui/game_over.tscn").instantiate()
	add_child(game_over_scene)
