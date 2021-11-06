extends KinematicBody2D

onready var state_machine = $States
onready var animation_player = $AnimationPlayer

var dir
export var speed = 100
var velocity

func _ready():
	state_machine.init(self)
	
func _physics_process(delta):
	state_machine.run()
	
func move():
	dir = get_local_mouse_position().normalized()
	velocity = speed * dir
	velocity = move_and_slide(velocity, Vector2.UP)

func play_animation(animation):
	if animation_player.current_animation == animation:
		return
	else:
		animation_player.play(animation)
