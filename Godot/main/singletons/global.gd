extends Node

var dev = OS.is_debug_build()

var playing = false setget set_playing, get_playing
var hunger = 0
var max_hunger = 1
var apples_left = 0
var level_score = 0
var total_score = 0
var last_level = 5

func dprint(pstr) -> void:
	if dev:
		print(pstr)

func set_playing(val: bool) -> void:
	playing = val
	
func get_playing() -> bool:
	return playing
