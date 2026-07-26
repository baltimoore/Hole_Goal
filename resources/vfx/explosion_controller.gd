# https://www.youtube.com/watch?v=RtJJVjjM_-Q
extends Node3D

@onready var debris = $Debris
@onready var impact = $Fire
@onready var sfx = $SFX

@export var animation_time:float = 2.0

func explode():
	debris.emitting = true
	impact.emitting = true
	sfx.set_pitch_scale(randf_range(0.95,1.05))
	sfx.play()
	
	await get_tree().create_timer(animation_time).timeout
	queue_free()
