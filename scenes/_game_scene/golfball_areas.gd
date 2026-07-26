extends Area3D

@export var collision_shape: CollisionShape3D
@export var replacement_mesh: MeshInstance3D

const GlassShatterAnimation = preload("res://resources/vfx/glass_explosion.tscn")

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body == self: return
	if body is Golfball:
		SignalManager.golfball_goal.emit(get_meta("HoleValue"))
		var explosion: Node3D
		
		match get_meta("HoleType"):
			&"Window":
				explosion = GlassShatterAnimation.instantiate()
			&"Drainage":
				SignalManager.sfx_trigger_metal_clatter.emit()
			_:
				print("Unmanaged hole type!")
		
		get_tree().current_scene.add_child(explosion)
		explosion.global_position = body.global_position
		explosion.explode()
		body.queue_free()
