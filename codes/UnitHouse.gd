extends StaticBody2D


var mouseEntered = false
@onready var select = get_node("Selected")
var Selected = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	select.visible = Selected

func _input(event):
	if event.is_action_pressed("LeftClick"):
		if mouseEntered == true:
			Selected = !Selected
			if Selected == true:
				Game.spawnUnit(position)

func _on_mouse_entered():
	mouseEntered = true


func _on_mouse_exited():
	mouseEntered = false
