@tool
extends PanelContainer

func _load_readme():
	#var f := FileAccess.open("res://engine/docs/README.bb.txt", FileAccess.READ)
	#return f.get_as_text()
	return ""

	

# Called when the node enters the scene tree for the first time.
func _ready():
	$ReadmeRTLabel.text = _load_readme()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
