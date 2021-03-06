extends Control

onready var anim = $AnimationPlayer

func _ready():
	# For HTML, delay music start
	if OS.get_name() == "HTML5":
		yield(get_tree().create_timer(1), "timeout")
	MusicPlayer.switch_music("menu")

func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and event.pressed:
		SoundEffects.play_sound("start_game")
		anim.play("start_game")
		MusicPlayer.fade_out()
		yield(anim, "animation_finished")
		SceneHandler.goto_scene("res://levels/0/Level_0.tscn", self)
