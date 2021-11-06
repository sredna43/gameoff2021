extends Node2D
class_name Main


# Initialize game, display first scene
func _ready():
	SceneHandler.goto_scene("res://levels/0/Level_0.tscn", self)
	
