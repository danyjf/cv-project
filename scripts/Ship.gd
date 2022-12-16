extends KinematicBody

export var move_speed = 100
export var look_sensitivity = 5

var min_look_angle = -90.0
var max_look_angle = 90.0
var mouse_delta = Vector2()
var velocity = Vector3.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	rotation_degrees.x -= mouse_delta.y * look_sensitivity * delta
	rotation_degrees.x = clamp(rotation_degrees.x, min_look_angle, max_look_angle)
	rotation_degrees.y -= mouse_delta.x * look_sensitivity * delta
	
	mouse_delta = Vector2.ZERO

func _physics_process(_delta):
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

func _input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative
	if Input.is_action_just_released("esc"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
