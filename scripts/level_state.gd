class_name LevelState
extends Resource

@export var score := 0:
	set(value):
		score = value
		SignalManager.score_changed.emit(score)

@export var balls := 10:
	set(value):
		balls = value
		SignalManager.balls_changed.emit(balls)

@export var tutorial_read : bool = false
