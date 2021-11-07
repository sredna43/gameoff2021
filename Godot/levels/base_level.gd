extends Node2D
class_name Level

onready var viewport: Viewport = $DrawingLayer
onready var overlay: TextureRect = $Overlay
onready var bg: ColorRect = $BackgroundColor
onready var drawer: Node2D = $DrawingLayer/Drawer
onready var anim: AnimationPlayer = $AnimationPlayer
onready var player = $Player
var next_level

var pressed = false

# Total distance is roughly base_hunger * 4
export var base_hunger = 250

func _ready():
	var next_level_num = str(int(name) + 1)
	next_level = "res://levels/" + next_level_num  + "/Level_" + next_level_num + ".tscn"
	var level_size = overlay.get_texture().get_size()
	viewport.set_size(level_size)
	overlay.set_size(level_size)
	bg.set_size(level_size)
	anim.play("start")
	player.connect("winner", self, "win_level")
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		pressed = event.is_pressed()

func _physics_process(_delta):
		if pressed and Global.get_playing():
			drawer.draw_at(player.position)
		#yield(VisualServer, "frame_post_draw")
		var texture = viewport.get_texture()
		overlay.material.set_shader_param("mask_texture", texture)
			

func start():
	Global.set_playing(true)
	
func win_level():
	Global.set_playing(false)
	SceneHandler.goto_scene(next_level, self)
