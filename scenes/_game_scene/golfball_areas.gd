extends Area3D

@export var collision_shape: CollisionShape3D
@export var replacement_mesh: MeshInstance3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body == self: return
	print("Something has entered!")
	if body is Golfball:
		body.queue_free()
