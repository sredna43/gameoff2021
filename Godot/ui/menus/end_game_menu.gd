extends Control

onready var score_text = $CenterContainer/MarginContainer/Label
onready var anim = $AnimationPlayer

func _ready():
	score_text.text = "Final score: %s" % str(Global.total_score)
	Global.dprint(str(Global.total_score))

func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and event.pressed:
		SoundEffects.play_sound("start_game")
		anim.play("start_game")
		yield(anim, "animation_finished")
		SceneHandler.goto_scene("res://levels/0/Level_0.tscn", self)
