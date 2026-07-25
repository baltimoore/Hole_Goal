extends Node3D

@export var max_power := 30.0
@export var power_charge_rate := 18.0

@export var aiming: bool = false

@export var ball_scene: PackedScene

@onready var laser: MeshInstance3D = $Laser
@onready var launch_origin: Node3D = $barrel

var power := 0.0
var charging := false

func _ready() -> void:
	laser.visible = false

func _process(delta: float) -> void:
	aiming = Input.is_action_pressed('aim_action')
	charging = Input.is_action_pressed('shoot_action')

	# aiming logic: just laser
	if aiming and not charging:
		laser.visible = true
		#arc.visible = false
		power = 0.0
		return

	# charging: laser off, + growing arc
	if aiming and charging:
		laser.visible = false
		#arc.visible = true
		power = min(max_power, power + power_charge_rate * delta)
		#update_arc(aim_dir_current, power)
		return

	# If aim was released, stop charging and hide
	if not aiming:
		laser.visible = false
		#arc.visible = false
		charging = false
		power = 0.0
		return

	# Finally: launch on shoot release while aiming
	# We handle release in _input to get exact edge timing.
	# (So do nothing here.)

func _input(event: InputEvent) -> void:
	# Launch when charging and shoot is released (aim must still be held)
	if event.is_action_released('shoot_action') and Input.is_action_pressed('aim_action'):
		if charging:
			laser.visible = false
			#arc.visible = false
			var direction = (get_parent_node_3d().global_transform.basis.z).normalized()
			launch_ball(-direction, power)
			charging = false
			power = 0.0

func launch_ball(direction:Vector3, power:float) -> void:
	var b = ball_scene.instantiate()
	get_tree().current_scene.get_node('City').add_child(b)
	b.global_position = launch_origin.global_position
	b.launch(direction, power)
