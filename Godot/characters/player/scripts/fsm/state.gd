extends Node2D
class_name PlayerState

export var tag = ""

func _ready():
	tag = name.to_lower()
	
func enter(player):
	Global.dprint("Entering " + tag)
	player.anim.playback_speed = 1
	player.play_animation(tag)
	pass
	
func run(_player):
	return ""
	
func exit(_player):
	Global.dprint("Leaving " + tag)
