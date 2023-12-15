extends SubViewport

@onready var camera = $Camera
var unit_house = preload("res://UI/Minimap Sprites/unit_houseSprite.tscn")
var unit = preload("res://UI/Minimap Sprites/UnitSprite.tscn")
var tree = preload("res://UI/Minimap Sprites/TreeSprite.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	updateMap()
	
	
func updateMap():
	var HousesPath = get_tree().get_root().get_node("World/Houses")
	var UnitsPath = get_tree().get_root().get_node("World/Units")
	var TreePath = get_tree().get_root().get_node("World/Objects")
	
	var MiniMapSprite = 0
	for i in HousesPath.get_child_count():
		var house = unit_house.instantiate()
		house.set_name("House"+str(MiniMapSprite))
		MiniMapSprite += 1
		add_child(house)
		house.position = HousesPath.get_child(i).position
		
	MiniMapSprite = 0
	for i in UnitsPath.get_child_count():
		var unit = unit.instantiate()
		unit.set_name("Unit"+str(MiniMapSprite))
		MiniMapSprite += 1
		get_node("Units").add_child(unit)
		
	MiniMapSprite = 0
	for i in TreePath.get_child_count():
		var tree = tree.instantiate()
		tree.set_name("Tree"+str(MiniMapSprite))
		MiniMapSprite += 1
		add_child(tree)
		tree.position = TreePath.get_child(i).position
	
	
	
func _process(delta):
	var CameraPath = get_tree().get_root().get_node("World/Camera")
	var UnitsPath = get_tree().get_root().get_node("World/Units")
	
	camera.offset = CameraPath.offset/2
	camera.zoom = CameraPath.zoom/2
	
	var UnitsTotal = get_node("Units")
	for i in UnitsPath.get_child_count():
		UnitsTotal.get_child(i).position = UnitsPath.get_child(i).position
		
