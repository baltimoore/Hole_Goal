extends Area3D

@export var required_group := "golf_balls"

func _ready() -> void:
	connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node) -> void:
	print("Something has entered!")
