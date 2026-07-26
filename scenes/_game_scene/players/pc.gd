# 3d movements with 3rd person camera
# https://www.youtube.com/watch?v=HgYTFYSUJ1I
# https://www.youtube.com/watch?v=cJ4FAGSIALo
extends CharacterBody3D

@export var WALK_VELOCITY: float = 17.0
@export var SPRINT_MULTIPLIER: float = 1.75
@export var MIDAIR_STRAFE_MULTIPLIER: float = 0.5
@export var JUMP_VELOCITY: float = 15.0
@export var GRAVITY: float = ProjectSettings.get_setting('physics/3d/default_gravity')

@export var MOUSE_SENSITIVITY_X: float = 0.010
@export var MOUSE_SENSITIVITY_Y: float = 0.005

@export var SPRING_ARM_LENGTH: float = 3.0
@export var SPRING_ARM_AIMING: float = 1.5

@onready var SpringArm: Node3D = $SpringArm3D
@onready var model: Node3D = $Model

#capture user mouse in game window
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	# read sensitivity from game config
	MOUSE_SENSITIVITY_X = \
		float(Config.get_config(AppSettings.INPUT_SECTION, &"MouseSensitivityX", MOUSE_SENSITIVITY_X))
	MOUSE_SENSITIVITY_Y = \
		float(Config.get_config(AppSettings.INPUT_SECTION, &"MouseSensitivityY", MOUSE_SENSITIVITY_Y))

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
	var camera_yaw = Basis(Vector3.UP, SpringArm.rotation.y)
	
	# reduce midair mobility
	if not is_on_floor():
		input_vector *= MIDAIR_STRAFE_MULTIPLIER
	var movement_vector = (
		camera_yaw * Vector3(input_vector.x, 0, input_vector.y).normalized()
	)
	
	velocity.x = movement_vector.x * WALK_VELOCITY
	velocity.z = movement_vector.z * WALK_VELOCITY
	if Input.is_action_pressed("sprint"):
		velocity.x *= SPRINT_MULTIPLIER
		velocity.z *= SPRINT_MULTIPLIER
	
	move_and_slide()

# rotate body in direction of movement
func _process(delta: float) -> void:
	if Input.is_action_pressed("aim_action"):
		model.rotation.y = lerp_angle(model.rotation.y, SpringArm.rotation.y, delta * 10)
		return
		
	var horizontal_velocity = Vector2(velocity.x, velocity.z)
	if (horizontal_velocity.length_squared() < 0.001): 
		return #don't care if char don't move
		 
	# rotate model linearly, instead of snapping
	var target_rotation = atan2(-velocity.x, -velocity.z)
	model.rotation.y = lerp_angle(model.rotation.y, target_rotation, delta*10)

func _input(event: InputEvent) -> void:
	# camera rotation around player character
	if (event is InputEventMouseMotion):
		SpringArm.rotation.y -= (event.relative.x * MOUSE_SENSITIVITY_X)
		var vertical_rotation = SpringArm.rotation.x - (event.relative.y * MOUSE_SENSITIVITY_Y)
		# prevent camera from flipping around pc
		SpringArm.rotation.x = clamp(vertical_rotation, -PI/2, PI/2)
		
	# aim thing
	if (event.is_action_pressed('aim_action')):
		SpringArm.spring_length = SPRING_ARM_AIMING
		
	# aim thing
	if (event.is_action_released('aim_action')):
		SpringArm.spring_length = SPRING_ARM_LENGTH
