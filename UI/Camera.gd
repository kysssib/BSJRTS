extends Camera2D

var mousePos = Vector2()
var mousePosGlobal = Vector2()
var start = Vector2()
var startV = Vector2()
var end = Vector2()
var endV = Vector2()
var isDragging = false
signal area_selected
signal start_move_selection

# 카메라 이동 관련 변수
@export var camera_speed = 100
var screen_margin = 20
@export var zoom_speed = 0.01  # 조정할 줌 속도


@onready var box = get_node("../UI/Panel")
@warning_ignore("unused_parameter", "unused_parameter")

func zoom_in():
	zoom /= (1.0 + zoom_speed)

func zoom_out():
	zoom *= (1.0 + zoom_speed)

func _ready():
	connect("area_selected", Callable(get_parent(), "_on_area_selected"))
	

@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_just_pressed("LeftClick"):
		start = mousePosGlobal
		startV = mousePos
		isDragging = true
		
	if isDragging:
		end = mousePosGlobal
		endV = mousePos
		draw_area()
	
	if Input.is_action_just_released("LeftClick"):
		if startV.distance_to(mousePos) > 20:
			end = mousePosGlobal
			endV = mousePos
			isDragging = false
			draw_area(false)
			emit_signal("area_selected", self)
		else:
			end = start
			isDragging = false
			draw_area(false)
		
	# 마우스 위치 확인
	var mouse_position = get_viewport().get_mouse_position()
	
	# 화면 경계 체크 및 카메라 이동
	if mouse_position.x < screen_margin:
		if offset.x - camera_speed * delta > limit_left:
			offset.x -= camera_speed * delta
	elif mouse_position.x > get_viewport_rect().size.x - screen_margin:
		if offset.x + camera_speed * delta < limit_right:
			offset.x += camera_speed * delta

	if mouse_position.y < screen_margin:
		if offset.y - camera_speed * delta > limit_top:
			offset.y -= camera_speed * delta
	elif mouse_position.y > get_viewport_rect().size.y - screen_margin:
		if offset.y + camera_speed * delta < limit_bottom:
			offset.y += camera_speed * delta
	
	# 카메라 위치 업데이트
	set_offset(offset)

func _input(event):
	if event is InputEventMouse:
		mousePos = event.position
		mousePosGlobal = get_global_mouse_position()
	
	if event is InputEventMouseButton:
		# 마우스 휠 이벤트 확인
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_in()
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_out()		

func draw_area(s=true):
	box.size = Vector2(abs(startV.x - endV.x), abs(startV.y - endV.y))
	var pos = Vector2()
	pos.x = min(startV.x, endV.x)
	pos.y = min(startV.y, endV.y)
	box.position = pos
	box.size *= int(s)
	
