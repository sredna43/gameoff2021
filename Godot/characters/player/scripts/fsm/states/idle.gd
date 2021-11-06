extends PlayerState

func run(_player):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		return "move"
	return ""
