extends CanvasLayer

func _init():
	pass

func _ready():
	$Message.visible = false
	E.coin_collected.connect(_on_coin_collected)
	E.show_message.connect(_on_show_message)

func _on_coin_collected(coins):
	$Coins.text = str(coins)
	
func _on_show_message(message: String) -> void:
	$Message.text = message
	$Message.visible = true
	$MessageTimer.start(message.length() / 5)

func _on_message_timer_timeout():
	$Message.visible = false

