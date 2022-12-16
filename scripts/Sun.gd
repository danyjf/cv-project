extends KinematicBody

var scaleUp = false
var scaleTopLimit = 10
var scaleBottomLimit = 9

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(deg2rad(8)*delta)
#	if (scale == Vector3(scaleTopLimit, scaleTopLimit, scaleTopLimit)):
#		scale -= Vector3(0.01, 0.01, 0.01)
#		scaleUp = false
#		print("1")
#	elif (scale == Vector3(scaleBottomLimit, scaleBottomLimit, scaleBottomLimit)):
#		scale += Vector3(0.01, 0.01, 0.01)
#		scaleUp = true
#		print("2")
#	elif (scaleUp == true):
#		scale += Vector3(0.01, 0.01, 0.01)
#		print("3")
#	elif (scaleUp == false):
#		scale -= Vector3(0.01, 0.01, 0.01)
#		print("4")
