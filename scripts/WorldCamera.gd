extends Camera

func _input(_event):
	if Input.is_action_just_pressed("a"):
		make_current()
