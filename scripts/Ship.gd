extends KinematicBody

signal planet_selection

export var move_speed = 100
export var look_sensitivity = 5

var min_look_angle = -90.0
var max_look_angle = 90.0
var mouse_delta = Vector2()
var velocity = Vector3.ZERO

enum movement_mode {FREE_MODE, ORBIT_MODE}
var current_mode = movement_mode.FREE_MODE
onready var orbit_target = get_node("/root/WorldEnvironment/Sun")
var orbit_pivot

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	orbit_pivot = get_parent()

func _process(delta):
	match current_mode:
		movement_mode.FREE_MODE:
			free_camera(delta)
		movement_mode.ORBIT_MODE:
			orbit_camera(delta)

func _physics_process(_delta):
	match current_mode:
		movement_mode.FREE_MODE:
			free_movement()
		movement_mode.ORBIT_MODE:
			orbit_movement()

func free_movement():
	velocity = Vector3.ZERO
	
	var input = Vector2()
	if Input.is_action_pressed("move_forward"):
		input.y -= 1
	if Input.is_action_pressed("move_backwards"):
		input.y += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
	input = input.normalized()
	
	var forward = transform.basis.z
	var right = transform.basis.x
	var relativeDir = (forward * input.y + right * input.x)
	
	velocity = relativeDir * move_speed

	velocity = move_and_slide(velocity)

func free_camera(delta):
	rotation_degrees.x -= mouse_delta.y * look_sensitivity * delta
	rotation_degrees.x = clamp(rotation_degrees.x, min_look_angle, max_look_angle)
	rotation_degrees.y -= mouse_delta.x * look_sensitivity * delta
	
	mouse_delta = Vector2.ZERO

func orbit_movement():
	orbit_pivot.global_transform.origin = orbit_target.global_transform.origin

func orbit_camera(delta):
	orbit_pivot.rotation_degrees.x -= mouse_delta.y * look_sensitivity * delta
	orbit_pivot.rotation_degrees.x = clamp(orbit_pivot.rotation_degrees.x, min_look_angle, max_look_angle)
	orbit_pivot.rotation_degrees.y -= mouse_delta.x * look_sensitivity * delta
	
	mouse_delta = Vector2.ZERO

func _input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative
	
	if Input.is_action_just_released("esc"):
		emit_signal("planet_selection")

func _on_PlanetButton_pressed(name, distance):
	$Camera.make_current()
	if name == "FreeMode":
		current_mode = movement_mode.FREE_MODE
		orbit_pivot.rotation_degrees.x = 0
		orbit_pivot.rotation_degrees.y = 0
		return
	
	for planet in get_tree().get_nodes_in_group("planets"):
		if planet.name == name:
			current_mode = movement_mode.ORBIT_MODE
			orbit_target = planet
			rotation_degrees.x = 0
			rotation_degrees.y = 0
			transform.origin.x = 0
			transform.origin.y = 0
			transform.origin.z = distance
