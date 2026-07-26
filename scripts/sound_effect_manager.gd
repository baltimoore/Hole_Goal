extends AudioStreamPlayer

const sfx_glass_shatter = preload("res://resources/audio/glass.mp3")
const sfx_metal_clatter = preload("res://resources/audio/340915__passairmangrace__metalclang1_loud_bip.wav")

func _ready() -> void:
	SignalManager.sfx_trigger_glass_shatter.connect(_glass_shatter_play)
	SignalManager.sfx_trigger_metal_clatter.connect(_metal_clatter_play)
	
func _glass_shatter_play() ->void:
	#print('shattering triggererd')
	set_pitch_scale(randf_range(0.95,1.05))
	self.stream = sfx_glass_shatter
	play()

func _metal_clatter_play() ->void:
	#print('clattering triggererd')
	set_pitch_scale(randf_range(0.95,1.05))
	self.stream = sfx_metal_clatter
	play()
