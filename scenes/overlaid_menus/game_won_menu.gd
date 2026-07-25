extends GameWonMenu

# make sure player can interact with overlay menus
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	super._ready()
