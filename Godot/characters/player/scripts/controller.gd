extends KinematicBody2D

### SETUP
onready var state_machine = $States
export var hunger = 100 # default set for tool

func _ready():
	state_machine.init(self)
	hunger = get_parent().base_hunger
	
func _physics_process(_delta):
	state_machine.run()


### MOVEMENT
var dir
export var max_speed = 250
export var speed = 100
var velocity = Vector2.ZERO

func move():
	dir = get_local_mouse_position()
	# Don't allow for faster movement diagonally
	if dir.length() > max_speed:
		velocity = dir.normalized() * max_speed
	else:
		velocity = dir
	velocity = move_and_slide(velocity, Vector2.UP)
	hunger -= abs(velocity.length() * 0.001)
	Global.dprint(hunger)
	if hunger <= 0:
		starved()


### SIGNALS
signal winner
signal starved

func goal_entered():
	emit_signal("winner")
	Global.dprint("winner")

func starved():
	emit_signal("starved")
	Global.dprint("starved")
	

### LOOKS
onready var animation_player = $AnimationPlayer

func play_animation(animation):
	if animation_player.current_animation == animation:
		return
	else:
		animation_player.play(animation)

