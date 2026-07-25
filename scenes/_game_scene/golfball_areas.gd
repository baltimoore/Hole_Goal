extends Area3D

@export var required_group := "golf_balls"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body == self: return
	print("Something has entered!")
	if body is Golfball:
		body.queue_free()
