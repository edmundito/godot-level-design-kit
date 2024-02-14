@tool
extends EditorPlugin

var _dock: Control

func _init():
	add_autoload_singleton("G", "res://addons/platform_level_design_kit/plugin/scripts/autoloads/globals.gd")
	add_autoload_singleton("E", "res://addons/platform_level_design_kit/plugin/scripts/autoloads/engine.gd")

func _enter_tree():
	_dock = preload("res://addons/platform_level_design_kit/plugin/scenes/editor/dock_panel.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, _dock)


func _exit_tree():
	remove_control_from_docks(_dock)
	_dock.free()
