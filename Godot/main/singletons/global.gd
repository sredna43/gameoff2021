extends Node

var dev = OS.is_debug_build()

var playing = false setget set_playing, get_playing
var hunger = 0
var max_hunger = 0

func dprint(pstr) -> void:
	if dev:
		print(pstr)

func set_playing(val: bool) -> void:
	playing = val
	
func get_playing() -> bool:
	return playing
