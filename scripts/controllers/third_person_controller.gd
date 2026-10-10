extends Node
class_name ThirdPersonController

@export var movement_speed: float = 5.0
@export var acceleration: float = 30.0
@export var friction: float = 50.0
@export var air_friction: float = 20.0
@export var jump_strength: float = 8.0
@export var number_of_jumps: int = 1
@export var gravity_strength: float = 20.0

@export var mouse_sensitivity: float = 0.002
@export var gamepad_sensitivity: float = 2.5
@export var pitch_min_degrees: float = -60.0
@export var pitch_max_degrees: float = 60.0

@export var camera_pivot: Node3D

var player: CharacterBody3D
var jumps_remaining: int
var pitch: float = 0.0
var mouse_captured: bool = true


func _ready() -> void:
	player = get_parent() as CharacterBody3D
	if player == null:
		push_error("ThirdPersonController must be a child of a CharacterBody3D.")
		set_physics_process(false)
		return

	if camera_pivot == null:
		push_error("Assign the camera pivot in the Inspector.")
		set_physics_process(false)
		return

	jumps_remaining = number_of_jumps
	pitch = camera_pivot.rotation.x
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	_handle_gamepad_look(delta)
	_handle_movement(delta)
	_handle_jump()
	_apply_gravity(delta)

	player.move_and_slide()

	if player.is_on_floor():
		jumps_remaining = number_of_jumps


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and mouse_captured:
		_rotate_camera(event.relative)


func _handle_gamepad_look(delta: float) -> void:
	var look_input := Input.get_vector(
		"camera_left",
		"camera_right",
		"camera_up",
		"camera_down"
	)

	if look_input.length_squared() > 0.0:
		_rotate_camera(look_input * gamepad_sensitivity / mouse_sensitivity * delta)


func _rotate_camera(relative_motion: Vector2) -> void:
	player.rotate_y(-relative_motion.x * mouse_sensitivity)
	
	pitch -= relative_motion.y * mouse_sensitivity
	pitch = clamp(
		pitch,
		deg_to_rad(pitch_min_degrees),
		deg_to_rad(pitch_max_degrees)
	)
	camera_pivot.rotation.x = pitch


func _handle_movement(delta: float) -> void:
	var input := Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_back"
	)
	
	# Move relative to the player's yaw, so forward input follows the camera direction.
	var direction := player.global_basis * Vector3(input.x, 0.0, input.y)
	direction.y = 0.0
	direction = direction.normalized()
	
	var horizontal_velocity := Vector3(
		player.velocity.x,
		0.0,
		player.velocity.z
	)
	
	var target_velocity := direction * movement_speed
	if not input.is_zero_approx():
		# Acceleration while steering, both on the ground and in the air.
		player.velocity.x = move_toward(
			player.velocity.x, target_velocity.x, acceleration * delta
		)
		player.velocity.z = move_toward(
			player.velocity.z, target_velocity.z, acceleration * delta
		)
	elif player.is_on_floor():
		# Stop more quickly when there's no input on the ground.
		player.velocity.x = move_toward(player.velocity.x, 0.0, friction * delta)
		player.velocity.z = move_toward(player.velocity.z, 0.0, friction * delta)
	else:
		# Gradually reduce horizontal momentum when there's no input in the air.
		player.velocity.x = move_toward(player.velocity.x, 0.0, air_friction * delta)
		player.velocity.z = move_toward(player.velocity.z, 0.0, air_friction * delta)


func _handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and jumps_remaining > 0:
		player.velocity.y = jump_strength
		jumps_remaining -= 1


func _apply_gravity(delta: float) -> void:
	if player.is_on_floor():
		if player.velocity.y < 0.0:
			player.velocity.y = 0.0
	else:
		player.velocity.y -= gravity_strength * delta
