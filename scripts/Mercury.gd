extends KinematicBody

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(deg2rad(4)*delta)
