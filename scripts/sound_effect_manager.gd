extends Node

var sfx_glass_shatter = preload("res://resources/audio/glass.mp3")

func _ready() -> void:
	SignalManager.sfx_trigger_glass_shatter.connect(glass_shatter_play)
	
func glass_shatter_play() ->void:
	print('shattering triggererd')
	$SoundeffectsPlayer.stream = sfx_glass_shatter
	$SoundeffectsPlayer.play
