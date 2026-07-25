extends Node
@export var tutorial_scenes : Array[PackedScene]
@export var open_delay : float = 0.25
@export var auto_open : bool = false

func open_tutorials() -> void:
	if open_delay > 0.0:
		await get_tree().create_timer(open_delay, false).timeout

	var initial_focus_control: Control = get_viewport().gui_get_focus_owner()

	for tutorial_scene in tutorial_scenes:
		await _open_tutorial_scene(tutorial_scene, initial_focus_control)


func open_tutorial(index: int) -> void:
	if index < 0 or index >= tutorial_scenes.size():
		push_warning("Tutorial index %d is out of bounds." % index)
		return

	if open_delay > 0.0:
		await get_tree().create_timer(open_delay, false).timeout

	var initial_focus_control: Control = get_viewport().gui_get_focus_owner()

	await _open_tutorial_scene(tutorial_scenes[index], initial_focus_control)


func _open_tutorial_scene(
	tutorial_scene: PackedScene,
	initial_focus_control: Control
) -> void:
	var tutorial_menu: OverlaidMenu = tutorial_scene.instantiate()
	if tutorial_menu == null:
		push_warning("Tutorial failed to open %s" % tutorial_scene)
		return

	get_tree().current_scene.call_deferred("add_child", tutorial_menu)
	await tutorial_menu.tree_exited

	if is_inside_tree() and initial_focus_control:
		initial_focus_control.grab_focus()

func _ready() -> void:
	if auto_open:
		open_tutorials()
