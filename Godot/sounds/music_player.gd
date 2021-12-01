extends Node

onready var tween = get_node("Tween")
var current_track
var fade = "in"

func switch_music(track: String):
	fade = "in"
	track = track.to_lower()
	if track == current_track:
		return
	current_track = track
	if track == 'level':
		$Menu.stop()
		$Level.play()
	if track == 'menu':
		$Level.stop()
		$Menu.play()


export var transition_duration = 1.00
export var transition_type = 1 # TRANS_SINE

func fade_out():
	var stream_player
	if current_track == 'menu':
		stream_player = $Menu
	if current_track == 'level':
		stream_player = $Level
	tween.interpolate_property(stream_player, "volume_db", 0, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween.start()
	fade = "out"
	current_track = ""
	

func _on_Tween_tween_completed(object, _key):
	if fade == "out":
		object.stop()
