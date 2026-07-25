class_name LevelState
extends Resource

@export var score:int = 0
@export var balls:int = 10
@export var tutorial_read : bool = false

func _ready() ->void:
	SignalManager.connect('golfball_shot', _on_golfball_shot)
	
func _on_golfball_shot() ->void:
	balls -=1
	if balls <= 0:
		#trigger game over
		print()
