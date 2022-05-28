extends Sprite

onready var signal_hub = get_node("/root/SignalHub")

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var x = int(mouse_pos.x / 32) * 32
	var y = int(mouse_pos.y / 32) * 32
	
	position.x = x
	position.y = y

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("l_click"):
		signal_hub.emit_signal("cursor_l_click", position)
	if event.is_action_pressed("r_click"):
		signal_hub.emit_signal("cursor_r_click", position)
