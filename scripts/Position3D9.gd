extends Spatial

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(deg2rad(8.04)*delta)
