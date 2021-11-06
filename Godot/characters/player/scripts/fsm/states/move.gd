extends PlayerState

func run(player):
	player.move()
	if not Input.is_mouse_button_pressed(BUTTON_LEFT):
		return "idle"
	return ""

