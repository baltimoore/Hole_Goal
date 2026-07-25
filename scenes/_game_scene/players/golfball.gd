extends RigidBody3D
class_name Golfball

#@export var initial_speed: float = 20.0
@export var decay_time:float = 60.0
var _still_timer: float = 0.0

# Launch mapping
@export var horiz_speed_per_power := 1
@export var vertic_speed_per_power := 0.8

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

func launch(direction: Vector3, power: float) -> void:
	# Horizontal direction (ignore Y)
	var horiz := Vector3(direction.x, 0.0, direction.z)

	var horiz_speed := power * horiz_speed_per_power
	var vert_speed := power * vertic_speed_per_power

	linear_velocity = (
		(horiz * horiz_speed) + 
		(Vector3.UP * vert_speed)
	)
