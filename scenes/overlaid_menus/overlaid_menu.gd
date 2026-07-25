extends OverlaidMenu

# make sure player can interact with overlay menus
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
