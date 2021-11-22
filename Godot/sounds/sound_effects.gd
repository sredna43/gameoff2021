extends Node

var is_moving setget set_is_moving

func play_sound(sound: String):
	sound = sound.to_lower()
	if sound == "crunch":
		$Crunch.play()
	if sound == "sniff":
		$Sniff.play()
	if sound == "click":
		$Click.play()
	if sound == "start_game":
		$StartGame.play()
		
func stop_sounds():
	$Crunch.stop()
	$Sniff.stop()

func set_is_moving(val: bool):
	if val == is_moving:
		return
	is_moving = val
	if val:
		$Move.play()
	else:
		$Move.stop()
