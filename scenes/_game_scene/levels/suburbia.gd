extends Node3D

var level_state : LevelState

signal score_changed(value:int)
signal balls_changed(value:int)

signal level_lost
signal level_won

func open_tutorials() -> void:
	$/root/GameUI/TutorialManager.open_tutorial(0)
	level_state.tutorial_read = true

func _ready() -> void:
	# connect signal listeners
	SignalManager.golfball_shot.connect(_register_shot)
	SignalManager.golfball_goal.connect(_register_strike)
	
	level_state = GameState.get_level_state(scene_file_path)
	
	level_state.initial_balls = 10
	level_state.score = 0
	score_changed.emit(level_state.score)
	balls_changed.emit(level_state.initial_balls)
	
	#if not level_state.tutorial_read:
	open_tutorials()

func _register_shot()->void:
	level_state.shots_spent += 1
	
	if level_state.shots_spent >= level_state.initial_balls :
		# give 5 seconds, in case player might actually be hitting a hole with their last ball
		await get_tree().create_timer(10.0).timeout
		emit_signal("level_lost")

func _register_strike(hole_value:int) -> void:
	level_state.score += hole_value
	if level_state.score >=8 : emit_signal("level_won")
	
