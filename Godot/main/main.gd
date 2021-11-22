extends Node2D
class_name Main


# Initialize game, display first scene
func _ready():
	SceneHandler.goto_scene_no_loading("res://ui/menus/MainMenu.tscn", self)
	
