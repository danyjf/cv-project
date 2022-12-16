extends KinematicBody

var speed = 100
var movement = Vector3.ZERO
var rot_speed = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("w"):
		movement = -transform.basis.z * speed
	if Input.is_action_pressed("a"):
		rotate_y(rot_speed * delta)
	if Input.is_action_pressed("s"):
		movement = transform.basis.z * speed
	if Input.is_action_pressed("d"):
		rotate_y(-rot_speed * delta)
	
	movement = move_and_slide(movement)
