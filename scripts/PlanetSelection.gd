extends CanvasLayer

func _ready():
	visible = false

func _on_Ship_planet_selection():
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_PlanetButton_pressed():
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
