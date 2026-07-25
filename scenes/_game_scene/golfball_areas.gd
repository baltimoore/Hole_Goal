extends Area3D

@export var collision_shape: CollisionShape3D
@export var replacement_mesh: MeshInstance3D


func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body == self: return
	if body is Golfball:
		print("golfball has entered!")
		body.queue_free()
		SignalManager.golfball_goal.emit(get_meta("HoleType"))
		if get_meta("HoleType") == &"Window":
			SignalManager.sfx_trigger_glass_shatter.emit
