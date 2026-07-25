extends RigidBody3D

@export var initial_speed: float = 20.0
@export var decay_time:float = 60.0
var _still_timer: float = 0.0

func _ready():
	pass  # Don't set velocity here
	
func _physics_process(delta: float) -> void:
	# prevent a massive pileup of balls for a buffer overload
	if linear_velocity.length() < 0.01: 
		_still_timer += delta
		if _still_timer >= decay_time:
			queue_free()
	else:
		_still_timer = 0.0
		

func launch(direction: Vector3) -> void:
	linear_velocity = direction * initial_speed
