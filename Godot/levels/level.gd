extends Node2D
class_name Level

onready var viewport: Viewport = $DrawingLayer
onready var overlay: TextureRect = $Overlay
onready var bg: ColorRect = $BackgroundColor
onready var drawer: Node2D = $DrawingLayer/Drawer
onready var anim: AnimationPlayer = $AnimationPlayer
onready var player = $Player
onready var hud: CanvasLayer = $HUD
onready var blackout: ColorRect = $Blackout
onready var next_level_num: String = str(int(name) + 1)
onready var next_level: String = "res://levels/%s/Level_%s.tscn" % [next_level_num, next_level_num]
onready var this_level_num: String = str(int(name))
onready var this_level: String = "res://levels/%s/Level_%s.tscn" % [this_level_num, this_level_num]

var pressed = false

# Total distance is roughly base_hunger * 4
export var base_hunger = 250

func _ready():
	next_level = "res://levels/0/Level_0.tscn"
	var level_size = overlay.get_texture().get_size()
	viewport.set_size(level_size)
	overlay.set_size(level_size)
	bg.set_size(level_size)
	blackout.show()
	blackout.set_self_modulate(Color(1, 1, 1, 1))
	anim.play("start")
	player.connect("winner", self, "win_level")
	player.connect("starved", self, "starved")
	Global.hunger = base_hunger
	Global.max_hunger = base_hunger
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		pressed = event.is_pressed()

func _physics_process(_delta):
	if pressed and Global.get_playing():
		drawer.draw_at(player.position)
	var texture = viewport.get_texture()
	overlay.material.set_shader_param("mask_texture", texture)

func start():
	Global.set_playing(true)
	
func win_level():
	Global.set_playing(false)
	SceneHandler.goto_scene(next_level, self)
	
func starved():
	Global.set_playing(false)
	hud.lose_game("You starved :(")
	anim.play("starved")
	yield(anim, "animation_finished")
	restart_level()

func restart_level():
	SceneHandler.goto_scene(this_level, self)
