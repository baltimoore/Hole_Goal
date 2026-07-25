# 3d movements with 3rd person camera
# https://www.youtube.com/watch?v=HgYTFYSUJ1I
# https://www.youtube.com/watch?v=cJ4FAGSIALo
extends CharacterBody3D

@export var WALK_VELOCITY: float = 17.0
@export var SPRINT_MULTIPLIER: float = 1.75
@export var JUMP_VELOCITY: float = 15.0
@export var GRAVITY: float = 40.0

@export var MOUSE_SENSITIVITY_X: float = 0.010
@export var MOUSE_SENSITIVITY_Y: float = 0.005

@onready var camera_pivot: Node3D = $SpringArm3D
@onready var model: Node3D = $Model
@onready var barrel: Node3D = $Model/head/barrel
@export var golfball : PackedScene

#capture user mouse in game window
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# movement
func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
		
	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# get input movement intent
	var input_vector = Input.get_vector("strafe_left","strafe_right","move_forward","move_backward")
	var camera_yaw = Basis(Vector3.UP, camera_pivot.rotation.y)
	var movement_vector = (
		#camera_pivot.global_basis # read camera rotation direction
		(camera_yaw * Vector3(input_vector.x, 0, input_vector.y).normalized()) # input movement intent
	)
	
	velocity.x = movement_vector.x * WALK_VELOCITY
	velocity.z = movement_vector.z * WALK_VELOCITY

	if Input.is_action_pressed("sprint"):
		velocity.x *= SPRINT_MULTIPLIER
		velocity.z *= SPRINT_MULTIPLIER
	move_and_slide()

# rotate body in direction of movement
func _process(delta: float) -> void:
	var horizontal_velocity = Vector2(velocity.x, velocity.z)
	if (horizontal_velocity.length_squared() < 0.001): 
		return #don't care if char don't move
		 
	# rotate model linearly, instead of snapping
	var target_rotation = atan2(-velocity.x, -velocity.z)
	model.rotation.y = lerp_angle(model.rotation.y, target_rotation, delta*10)

func _input(event: InputEvent) -> void:
	# camera rotation around player character
	if (event is InputEventMouseMotion):
		camera_pivot.rotation.y -= (event.relative.x * MOUSE_SENSITIVITY_X)
		var vertical_rotation = camera_pivot.rotation.x - (event.relative.y * MOUSE_SENSITIVITY_Y)
		# prevent camera from flipping around pc
		camera_pivot.rotation.x = clamp(vertical_rotation, -PI/2, PI/2)
		
	# shooting action
	if (event.is_action_pressed("shoot_action")):
		shoot()

func shoot() -> void:
	var b = golfball.instantiate()
	get_parent().get_node('City').add_child(b)
	b.global_position = barrel.global_position
	b.launch(-1 * model.global_transform.basis.z)
