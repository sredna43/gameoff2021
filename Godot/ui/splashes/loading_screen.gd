extends CanvasLayer

signal shown_fully_loaded

func show_fully_loaded():
	$AnimationPlayer.play("fully loaded")
	
func shown_fully_loaded():
	emit_signal("shown_fully_loaded")

func update(progress):
	$MarginContainer/CenterContainer/VBoxContainer/TextureProgress.value = progress
