extends Node

onready var tween_out = get_node("Tween")
var current_track

func switch_music(track: String):
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
	# tween music volume down to 0
	tween_out.interpolate_property(stream_player, "volume_db", 0, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()
	# when the tween ends, the music will be stopped

func _on_TweenOut_tween_completed(object, _key):
	# stop the music -- otherwise it continues to run at silent volume
	object.stop()
