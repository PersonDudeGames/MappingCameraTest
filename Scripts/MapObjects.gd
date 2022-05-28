extends Node2D

var WATER = preload("res://Scenes/WaterBody.tscn")
var Direction = preload("res://Scripts/Direction.gd").Direction
var _object_dict := {}

onready var signal_hub = get_node("/root/SignalHub")

func _ready() -> void:
	signal_hub.connect("cursor_l_click", self, "_insert_object")
	signal_hub.connect("cursor_r_click", self, "_remove_object")
	
func _insert_object(pos: Vector2) -> void:
	if is_instance_valid(_object_dict.get(pos)):
		return
	
	var water = WATER.instance()
	water.position = pos
	add_child(water)
	_object_dict[pos] = water
	
	var up = _object_dict.get(Vector2(pos.x, pos.y - 32))
	var right = _object_dict.get(Vector2(pos.x + 32, pos.y))
	var down = _object_dict.get(Vector2(pos.x, pos.y + 32))
	var left = _object_dict.get(Vector2(pos.x - 32, pos.y))
	
	if is_instance_valid(up):
		water.add_direction(Direction.UP)
		up.add_direction(Direction.DOWN)
	if is_instance_valid(right):
		water.add_direction(Direction.RIGHT)
		right.add_direction(Direction.LEFT)
	if is_instance_valid(down):
		water.add_direction(Direction.DOWN)
		down.add_direction(Direction.UP)
	if is_instance_valid(left):
		water.add_direction(Direction.LEFT)
		left.add_direction(Direction.RIGHT)

func _remove_object(pos: Vector2) -> void:
	var water = _object_dict.get(pos);
	if is_instance_valid(water):
		var up = _object_dict.get(Vector2(pos.x, pos.y - 32))
		var right = _object_dict.get(Vector2(pos.x + 32, pos.y))
		var down = _object_dict.get(Vector2(pos.x, pos.y + 32))
		var left = _object_dict.get(Vector2(pos.x - 32, pos.y))
		
		if is_instance_valid(up):
			up.remove_direction(Direction.DOWN)
		if is_instance_valid(right):
			right.remove_direction(Direction.LEFT)
		if is_instance_valid(down):
			down.remove_direction(Direction.UP)
		if is_instance_valid(left):
			left.remove_direction(Direction.RIGHT)
		
		
		_object_dict.erase(pos)
		water.queue_free()
	
