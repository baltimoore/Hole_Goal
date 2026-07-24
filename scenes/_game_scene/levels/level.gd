extends Node3D

var level_state : LevelState

#func open_tutorials() -> void:
	#%TutorialManager.open_tutorials()
	#level_state.tutorial_read = true
#
#func _ready() -> void:
	#level_state = GameState.get_level_state(scene_file_path)
	#if not level_state.tutorial_read:
		#open_tutorials()
#
#func _on_tutorial_button_pressed() -> void:
	#open_tutorials()
