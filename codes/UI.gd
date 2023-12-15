extends CanvasLayer


@onready var wood = $Wood
@onready var coin = $Coin


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	wood.text = "Wood : " + str(Game.Wood)
	coin.text = "Coin : " + str(Game.Coin)
