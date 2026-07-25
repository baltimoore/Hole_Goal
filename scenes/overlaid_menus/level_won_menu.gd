extends LevelWonMenu

# make sure player can interact with overlay menus
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#super._ready()
	
	var level_state = GameState.get_level_state(
		GameState.get_current_level_path()
	)

	display_results(level_state.evaluate())
		
func display_results(results: Dictionary) -> void:
	var text := "[center]"

	$MenuPanelContainer/MarginContainer/BoxContainer/TitleMargin/TitleLabel.text = 'Results'
	text += "[b]Score:[/b] %d\n" % results["score"]
	text += "[b]Shots:[/b] %d\n" % results["shots"]
	text += "[b]Accuracy:[/b] %.0f%%\n" % (results["accuracy"] * 100)
	$MenuPanelContainer/MarginContainer/BoxContainer/DescriptionMargin/DescriptionLabel.text = text
