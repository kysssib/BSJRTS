extends StaticBody2D


var totalTime = 5
var currTime
var units = 0
@onready var bar = $ProgressBar
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	currTime = totalTime
	bar.max_value = totalTime


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	bar.value = currTime
	if currTime <= 0:
		treeChopped()


func _on_chop_area_body_entered(body):
	if "Unit" in body.name:
		units += 1
		startChopping()


func _on_chop_area_body_exited(body):
	if "Unit" in body.name:
		units -= 1
		if units <= 0:
			timer.stop()


func _on_timer_timeout():
	var chopSpeed = 0.1*units
	currTime -= chopSpeed
	var tween = get_tree().create_tween()
	tween.tween_property(bar, "value", currTime, 0.5).set_trans(Tween.TRANS_LINEAR)
	

func startChopping():
	timer.start()
	
func treeChopped():
	Game.Wood += 1
	queue_free()
