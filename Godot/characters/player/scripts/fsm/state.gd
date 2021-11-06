extends Node2D
class_name PlayerState

export var tag = ""

func _ready():
	tag = name.to_lower()
	
func enter(player):
	if OS.is_debug_build():
		print("Entering " + tag)
	player.animation_player.playback_speed = 1
	player.play_animation(tag)
	pass
	
func run(_player):
	return ""
	
func exit(_player):
	if OS.is_debug_build():
		print("Leaving " + tag)
