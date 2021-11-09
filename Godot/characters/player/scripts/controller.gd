extends KinematicBody2D

### SETUP
onready var state_machine = $States
onready var level = get_parent()

func _ready():
	state_machine.init(self)
	position.y = 540
	Global.dprint(Global.hunger)
	
func _physics_process(_delta):
	if Global.playing:
		state_machine.run()


### MOVEMENT
var dir
export var max_speed = 130
export var speed = 2
var velocity = Vector2.ZERO

func move():
	dir = get_local_mouse_position()
	# Don't allow for faster movement diagonally
	if dir.length() > max_speed:
		velocity = dir.normalized() * max_speed
	else:
		velocity = dir
	velocity *= speed
	velocity = move_and_slide(velocity, Vector2.UP)
	Global.hunger -= abs(velocity.length() / (max_speed * speed))
	if Global.hunger <= 0:
		starved()


### SIGNALS/ACTIONS
signal winner
signal starved

func goal_entered():
	emit_signal("winner")
	Global.dprint("winner")

func starved():
	emit_signal("starved")
	Global.dprint("starved")

func eat(calories):
	Global.hunger += calories
	Global.dprint("Just ate " + str(calories) + " calories, hunger now at " + str(Global.hunger))

### LOOKS
onready var animation_player = $AnimationPlayer

func play_animation(animation):
	if animation_player.current_animation == animation:
		return
	else:
		animation_player.play(animation)

