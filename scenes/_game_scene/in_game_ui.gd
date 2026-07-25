extends Control

@export var score:int = 0
@export var balls:int = 10

const score_text = 'Score: %d'
const balls_text = 'Balls: %d'
@onready var score_label = $ScoreLabel
@onready var balls_label = $ScoreLabel2

func _ready() -> void:
	SignalManager.golfball_goal.connect(update_score)
	score_label.text = score_text % score
	balls_label.text = balls_text % balls
	
func update_score(hole_type: StringName):
	score += 1
	score_label.text = score_text % score

func update_shots() ->void:
	balls -= 1
	balls_label.text = balls_text % balls
	
