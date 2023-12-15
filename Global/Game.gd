extends Node

@onready var spawn = preload("res://Global/spawn_unit.tscn")

var Wood = 0
var Coin = 0


func spawnUnit(pos):
	var path = get_tree().get_root().get_node("World/UI")
	
	
	var hasSpawn = false
	for i in path.get_child_count():
		if "spawnUnit" in path.get_child(i).name:
			hasSpawn = true
	if hasSpawn == false:
		var spawnUnit = spawn.instantiate()
		spawnUnit.housePos = pos
		path.add_child(spawnUnit)
	
