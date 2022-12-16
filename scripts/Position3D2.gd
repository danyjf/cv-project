extends Position3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(deg2rad(10)*delta)
#	rotate_y(deg2rad(12)*delta)
#	rotate_z(deg2rad(12)*delta)
