extends CanvasLayer

func _init():
	pass

func _ready():
	$Message.visible = false
	E.coin_collected.connect(_on_coin_collected)
	E.gem_collected.connect(_on_gem_collected)
	E.heart_collected.connect(_on_heart_collected)
	E.show_message.connect(_on_show_message)
	
	#_on_coin_collected(E.coins)
	#_on_gem_collected(E.gems)
	#_on_heart_collected(E.heart)

func _on_coin_collected(coins):
	%Coins.text = str(coins)
	
func _on_gem_collected(gems):
	%Gems.text = str(gems)
	
func _on_show_message(message: String) -> void:
	$Message.text = message
	$Message.visible = true
	$MessageTimer.start(message.length() / 5)

func _on_message_timer_timeout():
	$Message.visible = false

func _on_heart_collected(hearts):
	%Hearts.text = str(hearts)
