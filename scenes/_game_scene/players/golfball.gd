extends RigidBody3D

@export var initial_speed: float = 20.0

func _ready():
	pass  # Don't set velocity here
	
func launch(direction: Vector3) -> void:
	linear_velocity = direction * initial_speed
