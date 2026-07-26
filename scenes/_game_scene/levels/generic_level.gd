extends Node3D

var level_state : LevelState

signal level_lost
signal level_won

@export var initial_balls:int = 10
@export var required_score: int = 8
@export var tutorial_index: int = 0

func open_tutorials() -> void:
	$/root/GameUI/TutorialManager.open_tutorial(tutorial_index)
	level_state.tutorial_read = true

func _ready() -> void:
	# connect signal listeners
	SignalManager.golfball_shot.connect(_register_shot)
	SignalManager.golfball_goal.connect(_register_strike)
	$World/Floor/Area3D.connect('player_died', _player_dead)
	
	level_state = GameState.get_level_state(scene_file_path)
	GameState.set_current_level(scene_file_path)
	
	level_state.initial_balls = initial_balls
	# no need to emit changes; this already resets it all
	
	#if not level_state.tutorial_read:
	open_tutorials()

func _register_shot()->void:
	level_state.shots_spent += 1
	if level_state.shots_spent < level_state.initial_balls :
		return
	# give 5 seconds, in case player might actually be hitting a hole with their last ball
	await get_tree().create_timer(3.0).timeout
	
	if level_state.score >= required_score :
		emit_signal("level_won")
	else:
		emit_signal("level_lost")

func _register_strike(hole_value:int) -> void:
	level_state.score += hole_value
			
func _player_dead() -> void:
	emit_signal('level_lost')
