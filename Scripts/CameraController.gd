extends Camera2D

var _threshold := 24
var _step := 4
var _zoom_step := 0.1
var events := {}
var last_drag_distance := 0
var zoom_sensitivity := 10
onready var viewport_size = get_viewport().size

func _process(delta: float) -> void:
	var local_mouse_pos = get_local_mouse_position()

	if local_mouse_pos.x < _threshold:
		position.x -= _step
	elif local_mouse_pos.x > viewport_size.x - _threshold:
		position.x += _step
		
	if local_mouse_pos.y < _threshold:
		position.y -= _step
	elif local_mouse_pos.y > viewport_size.y - _threshold:
		position.y += _step

func _zoom_in() -> void:
	zoom.x = clamp(zoom.x - _zoom_step, 0.1, zoom.x)
	zoom.y = clamp(zoom.y - _zoom_step, 0.1, zoom.y)

func _zoom_out() -> void:
	zoom.x = clamp(zoom.x + _zoom_step, zoom.x, 2)
	zoom.y = clamp(zoom.y + _zoom_step, zoom.y, 2)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		_zoom_in()
		viewport_size = get_viewport().size
	elif event.is_action_pressed("zoom_out"):
		_zoom_out()
		viewport_size = get_viewport().size
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
