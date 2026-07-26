extends Area3D

const GlassShatterAnimation = preload("res://resources/vfx/glass_explosion.tscn")
const MetalShatterAnimation = preload("res://resources/vfx/metal_explosion.tscn")
const BoardScene = preload("res://assets/board.tscn")

@onready var boards_container = $"/root/GameUI/ViewportContainer/ConfigurableSubViewport/Level/City/Boards"

func _ready() -> void:
	body_shape_entered.connect(_on_body_shape_entered)
	
func _on_body_shape_entered(
	body_rid: RID,
	body: Node3D,
	body_shape_index: int,
	local_shape_index: int
) -> void:
	if body is not Golfball:
		return

	var impact_shape_owner = shape_find_owner(local_shape_index)
	var hit_shape = shape_owner_get_owner(impact_shape_owner) as CollisionShape3D
	var impact_location = hit_shape.global_position

	SignalManager.golfball_goal.emit(get_meta("HoleValue"))
	_initiate_explosion(get_meta("HoleType"), impact_location)

	body.queue_free()
	_board_up_hole(hit_shape)

func _initiate_explosion(hole_type:StringName, impact_location:Vector3)->void :#animate explosion
	var explosion: Node3D
	match get_meta("HoleType"):
		&"Window":
			explosion = GlassShatterAnimation.instantiate()
		&"Drainage":
			explosion = MetalShatterAnimation.instantiate()
		_:
			print("Unmanaged hole type!", get_meta("HoleType"))
	get_tree().current_scene.add_child(explosion)
	explosion.global_position = impact_location
	explosion.explode()

func _board_up_hole(shape_that_was_hit:CollisionShape3D) ->void:
	var board = BoardScene.instantiate()
	# this is incorrect, but fsfr, it's consistently too high
	boards_container.add_child(board)
	board.rotation = shape_that_was_hit.rotation
	board.global_position = shape_that_was_hit.global_position
	
