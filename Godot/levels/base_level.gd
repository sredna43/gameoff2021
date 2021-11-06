extends Node2D
class_name Level

onready var viewport: Viewport = $DrawingLayer
onready var overlay: TextureRect = $Overlay
onready var bg: ColorRect = $BackgroundColor
onready var drawer: Node2D = $DrawingLayer/Drawer

var pressed = false

func _ready():
	var level_size = overlay.get_texture().get_size()
	viewport.set_size(level_size)
	overlay.set_size(level_size)
	bg.set_size(level_size)
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		pressed = event.is_pressed()

func _physics_process(_delta):
	if pressed:
		drawer.draw_at($Player.position)
		
	yield(VisualServer, "frame_post_draw")

	var texture = viewport.get_texture()

	overlay.material.set_shader_param("mask_texture", texture)
