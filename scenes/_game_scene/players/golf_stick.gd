extends Node3D

@export var max_power := 30.0
@export var power_charge_rate := 18.0

@export var aiming: bool = false

@export var ball_scene: PackedScene

@onready var laser: MeshInstance3D = $Laser
@onready var arch: Node3D = $Arch
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
		arch.visible = false
		power = 0.0
		return

	# charging: laser off, + growing arc
	if aiming and charging:
		laser.visible = false
		arch.visible = true
		power = min(max_power, power + power_charge_rate * delta)
		var direction = (get_parent_node_3d().global_transform.basis.z).normalized()
		rotation.x -= 0.03
		#calculate_trajectory(direction, power)
		return

	# If aim was released, stop charging and hide
	if not aiming:
		laser.visible = false
		arch.visible = false
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
			arch.visible = false
			var direction = (get_parent_node_3d().global_transform.basis.z).normalized()
			launch_ball(-direction, power)
			charging = false
			power = 0.0
			rotation.x = 0

func launch_ball(direction:Vector3, power:float) -> void:
	var b = ball_scene.instantiate()
	get_tree().current_scene.get_node('ViewportContainer/ConfigurableSubViewport/Level/City').add_child(b)
	# let's take into account the player's movement too
	b.global_position = launch_origin.global_position
	b.launch(direction, power)

# https://www.youtube.com/watch?v=VsT4OoNUEEc
#func calculate_trajectory(direction, power) -> void:
	#var velocity: Vector3 = direction * power
	#var tstep = 0.05
	#var gravity := ProjectSettings.get_setting('physics/3d/default_gravity') as float
	#
	#var start_pos :Vector3 = launch_origin.global_position
	#var line_start := start_pos
	#var line_end := start_pos
	#var points: PackedVector3Array = []
	#points.append(line_start)
	#
	## here we start calculating line points
	#for i in range(1,151):
		#line_start = line_end
		## calculate physics
		#velocity.y += -gravity * tstep
		#line_end = line_start + velocity*tstep
		## check for object collisions
		#var ray := raycast_query(line_start, line_end)
		#if not ray.is_empty():
			#line_end = ray.position
			#points.append(line_end)
			#break
		#points.append(line_end)
	## draw the line
	#draw_trajectory(points)
#
#func raycast_query(pointA:Vector3, pointB:Vector3) -> Dictionary:
	#var space_state = get_world_3d().direct_space_state
	#var query = PhysicsRayQueryParameters3D.create(pointA, pointB)
	#query.hit_from_inside = false
	#return space_state.intersect_ray(query)
#
#func draw_trajectory(points:PackedVector3Array):
	#print('drawing trajectory')
