extends Control

var score:int = 0
const score_text = 'Score: %d'
@onready var score_label = $ScoreLabel

func _ready() -> void:
	SignalManager.golfball_goal.connect(update_score)
	
func update_score(hole_type: StringName):
	score +=1
	score_label.text = score_text % score
