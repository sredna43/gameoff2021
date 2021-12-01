extends Node2D

onready var viewport: Viewport = $DrawingLayer
onready var overlay: TextureRect = $Overlay
onready var bg: ColorRect = $BackgroundColor
onready var drawer: Node2D = $DrawingLayer/Drawer
onready var anim: AnimationPlayer = $AnimationPlayer
onready var player = $Player
onready var camera = $Player/Camera2D
onready var hud: CanvasLayer = $HUD
onready var blackout: ColorRect = $Blackout
onready var next_level_num: String = str(int(name) + 1)
onready var next_level: String = "res://levels/%s/Level_%s.tscn" % [next_level_num, next_level_num]
onready var this_level_num: String = str(int(name))
onready var this_level: String = "res://levels/%s/Level_%s.tscn" % [this_level_num, this_level_num]
onready var start_pos: Position2D = $Positions/Start
onready var end_pos: Position2D = $Positions/End
onready var foods: Node2D = $Foods

var pressed = false
var level_score = 0

export var base_hunger = 250
export var level_size = Vector2(1920,1080)

func _ready():
	viewport.set_size(level_size)
	overlay.set_size(level_size)
	bg.set_size(level_size)
	blackout.show()
	blackout.set_self_modulate(Color(1, 1, 1, 1))
	player.position = start_pos.position
	player.end_dest = end_pos.position
	anim.play("start")
	player.connect("winner", self, "win_level")
	player.connect("starved", self, "starved")
	Global.hunger = base_hunger
	Global.max_hunger = base_hunger
	MusicPlayer.switch_music("level")
	SoundEffects.play_sound("sniff")
	Global.apples_left = foods.get_child_count()
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		pressed = event.is_pressed()

func _physics_process(_delta):
	drawer.draw_at(player.global_head_position)
	var texture = viewport.get_texture()
	overlay.material.set_shader_param("mask_texture", texture)
	SoundEffects.set_is_moving(pressed && Global.get_playing())

func start():
	Global.set_playing(true)
	
func win_level():
	anim.play("win")
	camera.zoom = Vector2(1, 1)
	yield(anim, "animation_finished")
	yield(player, "at_end")
	Global.total_score += Global.level_score
	if int(this_level_num) == Global.last_level:
		next_level = "res://ui/menus/EndGameMenu.tscn"
		SceneHandler.goto_scene_no_loading(next_level, self)
	else:
		SceneHandler.goto_scene(next_level, self)
	
func starved():
	Global.set_playing(false)
	hud.lose_game("You starved :(")
	anim.play("starved")
	yield(anim, "animation_finished")
	restart_level()

func restart_level():
	SceneHandler.goto_scene(this_level, self)
