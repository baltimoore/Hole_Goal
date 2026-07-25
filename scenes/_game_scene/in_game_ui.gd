extends Control

const score_text = "Score: %d"
const balls_text = "Balls: %d"

@onready var score_label = $ScoreLabel
@onready var balls_label = $ScoreLabel2

func _ready() -> void:
	SignalManager.score_changed.connect(update_score)
	SignalManager.balls_changed.connect(update_balls)

func update_score(value:int) -> void:
	score_label.text = score_text % value

func update_balls(value:int) -> void:
	balls_label.text = balls_text % value
