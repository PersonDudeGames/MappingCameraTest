extends StaticBody2D

var Direction = preload("res://Scripts/Direction.gd").Direction
var _directions := 0
var cell_size := 32
var WATER_BODY = get_script()
var sprite_map := {}
onready var sprite = $Sprite

func _ready() -> void:
	sprite_map[Direction.NONE] = Vector2.ZERO
	sprite_map[Direction.UP] = Vector2(cell_size * 2, 0)
	sprite_map[Direction.DOWN] = Vector2(cell_size * 4, 0)
	sprite_map[Direction.LEFT] = Vector2(cell_size * 3, 0)
	sprite_map[Direction.RIGHT] = Vector2(cell_size * 5, 0)
	sprite_map[Direction.UP + Direction.DOWN] = Vector2(cell_size * 6, cell_size)
	sprite_map[Direction.LEFT + Direction.RIGHT] = Vector2(cell_size * 7, cell_size)
	sprite_map[Direction.UP + Direction.DOWN + Direction.LEFT + Direction.RIGHT] = Vector2(cell_size, 0)
	sprite_map[Direction.UP + Direction.LEFT] = Vector2(cell_size * 6, 0)
	sprite_map[Direction.UP + Direction.RIGHT] = Vector2(cell_size, cell_size)
	sprite_map[Direction.DOWN + Direction.LEFT] = Vector2(cell_size * 7, 0)
	sprite_map[Direction.DOWN + Direction.RIGHT] = Vector2(0, cell_size)
	sprite_map[Direction.UP + Direction.LEFT + Direction.RIGHT] = Vector2(cell_size * 5, cell_size)
	sprite_map[Direction.DOWN + Direction.LEFT + Direction.RIGHT] = Vector2(cell_size * 3, cell_size)
	sprite_map[Direction.LEFT + Direction.UP + Direction.DOWN] = Vector2(cell_size * 2, cell_size)
	sprite_map[Direction.RIGHT + Direction.UP + Direction.DOWN] = Vector2(cell_size * 4, cell_size)

func add_direction(direction: int) -> void:
	_directions += direction
	_update_sprite()

func remove_direction(direction: int) -> void:
	_directions -= direction
	_update_sprite()

func _update_sprite() -> void:
	var map_pos = sprite_map.get(_directions)
	if map_pos != null:
		_set_sprite_region(map_pos)

func _set_sprite_region(pos: Vector2) -> void:
	sprite.region_rect.position = pos
