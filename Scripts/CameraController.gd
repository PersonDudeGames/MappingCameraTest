extends Camera2D

var Direction = preload("res://Scripts/Direction.gd").Direction

var _threshold := 24
var _step := 4
var _zoom_step := 0.1
var events := {}
var last_drag_distance := 0
var zoom_sensitivity := 10
var scroll_direction := 0

onready var up_left = Direction.UP + Direction.LEFT
onready var up_right = Direction.UP + Direction.RIGHT
onready var down_left = Direction.DOWN + Direction.LEFT
onready var down_right = Direction.DOWN + Direction.RIGHT

func _process(_delta: float) -> void:
	match scroll_direction:
		Direction.UP:
			position.y -= _step
		Direction.DOWN:
			position.y += _step
		Direction.LEFT:
			position.x -= _step
		Direction.RIGHT:
			position.x += _step
		up_left:
			position.y -= _step
			position.x -= _step
		up_right:
			position.y -= _step
			position.x += _step
		down_left:
			position.y += _step
			position.x -= _step
		down_right:
			position.y += _step
			position.x += _step
			
func _zoom_in() -> void:
	zoom.x = clamp(zoom.x - _zoom_step, 0.1, zoom.x)
	zoom.y = clamp(zoom.y - _zoom_step, 0.1, zoom.y)

func _zoom_out() -> void:
	zoom.x = clamp(zoom.x + _zoom_step, zoom.x, 2)
	zoom.y = clamp(zoom.y + _zoom_step, zoom.y, 2)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		_zoom_in()
	elif event.is_action_pressed("zoom_out"):
		_zoom_out()
	elif event is InputEventScreenTouch:
		if event.is_pressed():
			events[event.index] = event
		else:
			events.erase(event.index)
	elif event is InputEventScreenDrag:
		events[event.index] = event
		if events.size() == 1:
			position -= event.relative
		elif events.size() == 2:
			var drag_distance = events[0].position.distance_to(events[1].position)
			if abs(drag_distance - last_drag_distance) > zoom_sensitivity:
				if drag_distance < last_drag_distance:
					_zoom_out()
				else:
					_zoom_in()
				last_drag_distance = drag_distance


func _on_Top_mouse_entered() -> void:
	scroll_direction += Direction.UP


func _on_Top_mouse_exited() -> void:
	scroll_direction -= Direction.UP


func _on_Right_mouse_entered() -> void:
	scroll_direction += Direction.RIGHT


func _on_Right_mouse_exited() -> void:
	scroll_direction -= Direction.RIGHT


func _on_Bottom_mouse_entered() -> void:
	scroll_direction += Direction.DOWN


func _on_Bottom_mouse_exited() -> void:
	scroll_direction -= Direction.DOWN


func _on_Left_mouse_entered() -> void:
	scroll_direction += Direction.LEFT


func _on_Left_mouse_exited() -> void:
	scroll_direction -= Direction.LEFT
