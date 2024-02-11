@tool
extends EditorPlugin

func _init():
	add_autoload_singleton("G", "res://addons/platform_level_design_kit/plugin/scripts/autoloads/globals.gd")
	add_autoload_singleton("E", "res://addons/platform_level_design_kit/plugin/scripts/autoloads/engine.gd")

func _enter_tree():
	# Initialization of the plugin goes here.
	pass


func _exit_tree():
	# Clean-up of the plugin goes here.
	pass
