extends AudioStreamPlayer

var sfx_glass_shatter = preload("res://resources/audio/glass.mp3")

func _ready() -> void:
	SignalManager.sfx_trigger_glass_shatter.connect(_glass_shatter_play)
	
func _glass_shatter_play() ->void:
	print('shattering triggererd')
	self.stream = sfx_glass_shatter
	play()
