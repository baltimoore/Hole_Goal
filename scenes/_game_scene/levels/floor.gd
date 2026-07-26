extends Area3D

signal player_died

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body == self:
		return

	if body is CharacterBody3D:
		emit_signal('player_died')
	if body is Node3D:
		body.queue_free()
