extends Label


var travel = Vector2(0, -50)
var duration = 1
var spread = PI/2

func show_value(value, crit):#duration 수정하고 싶으면 파라미터 추가
	var tween = create_tween()
	text = "+"+str(value)+"g"
	pivot_offset = size/4
	
	var movement = travel.rotated(randi_range(-spread/2, spread/2))
	
	tween.tween_property(self, "position", position + movement, duration)
	
	#투명도 점차 조절
	tween.tween_property(self, "mordulate:a", 0.0, duration)
	
	if crit == true:
		modulate = Color(1, 0, 0)
		scale = scale * 2
		tween.tween_property(self, "scale", scale, 0.4)
	
	tween.play()
	tween.tween_callback(self.queue_free)
	
	
