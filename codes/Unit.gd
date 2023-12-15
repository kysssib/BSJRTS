extends CharacterBody2D


@export var selected = false
@onready var box = get_node("Box")
@onready var anim = get_node("AnimationPlayer")

@onready var target = position
var follow_cursor = false
var SPEED = 50

func _ready():
	set_selected(selected)
	add_to_group("units", true)
	
	anim.play("Idle")
	
func set_selected(value):
	selected = value
	box.visible = value

func _on_input_event(viewport, event, shape_idx):
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	if event.is_action_released("RightClick"):
		follow_cursor = false
		
func _physics_process(delta):
	if follow_cursor == true:
		if selected:
			target = get_global_mouse_position()
			#방향 따른 걸음 조정
			if velocity.x > 0:
				if velocity.y > 0:
					anim.play("Walk D L")
				elif velocity.y < 0:
					anim.play("Walk U R")
				else:
					anim.play("Walk Right")
			elif velocity.x < 0:
				if velocity.y > 0:
					anim.play("Walk D R")
				elif velocity.y < 0:
					anim.play("Walk U L")
				else:
					anim.play("Walk Left")
			else:
				if velocity.y > 0:
					anim.play("Walk Down")
				elif velocity.y < 0:
					anim.play("Walk Up")
				else:
					anim.play("Idle")
	velocity = position.direction_to(target) * SPEED
	
	if position.distance_to(target) > 10:
		move_and_slide()
	else:
		anim.stop()
