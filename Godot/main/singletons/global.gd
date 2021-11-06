extends Node

var dev = OS.is_debug_build()

func dprint(pstr) -> void:
	if dev:
		print(pstr)
