class_name LevelState
extends Resource

@export var targeted_balls := 0
@export var score := 0:
	set(value):
		score = value
		targeted_balls+=1
		SignalManager.score_changed.emit(score)

@export var initial_balls := 0
@export var shots_spent := 0:
	set(value):
		shots_spent = value
		SignalManager.balls_changed.emit(initial_balls - shots_spent)

@export var tutorial_read : bool = false

func evaluate() -> Dictionary:
	return {
		"shot": shots_spent,
		"accuracy": 0.0 if shots_spent == 0 else float(targeted_balls)/float(shots_spent),
		"score": score
	}
