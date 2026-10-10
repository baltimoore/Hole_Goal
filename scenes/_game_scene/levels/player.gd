extends CharacterBody3D

const THIRD_PERSON_CONTROLLER = preload("res://scripts/controllers/third_person_controller.gd")

@export var camera_pivot: Node3D

var movement_controller: ThirdPersonController

func _ready() -> void:
	movement_controller = THIRD_PERSON_CONTROLLER.new()
	movement_controller.name = "MovementController"
	movement_controller.camera_pivot = camera_pivot
	movement_controller.acceleration = 30.0
	movement_controller.friction = 50.0
	movement_controller.air_friction = 5.0
	add_child(movement_controller)
