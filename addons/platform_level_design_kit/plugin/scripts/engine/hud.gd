extends CanvasLayer

func _ready():
	E.coin_collected.connect(_on_coin_collected)

func _on_coin_collected(coins):
	
	$Coins.text = str(coins)
