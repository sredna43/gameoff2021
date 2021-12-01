extends KinematicBody2D

### SETUP
onready var state_machine = $States
onready var level = get_parent()
onready var anim = $AnimationPlayer
onready var sprite = $Sprite
var sprite_scale = Vector2(2, 2)
var velocity = Vector2.ZERO

export var global_head_position: Vector2
var start_pos
var starved

# Level win stuff
export var won = false
var end_dest = Vector2()
var pos_diff = Vector2()
var end_vel = Vector2()

func _ready():
	state_machine.init(self)
	won = false
	start_pos = position
	Global.dprint("Starting hunger: " + str(Global.hunger))
	
func _physics_process(delta):
	if Global.playing:
		state_machine.run()
	if won:
		sprite.rotation_degrees = 0
		play_animation("move")
		pos_diff = end_dest - position
		end_vel = pos_diff * 2 * delta
		position += end_vel
	if pos_diff.length() < 1:
		emit_signal("at_end")


### MOVEMENT
var dir
export var max_speed = 130
export var speed: float = 1.3

func move():
	dir = get_local_mouse_position()
	global_head_position = position + dir.normalized() * 25
	set_look_angle()
	
	# Don't allow for faster movement diagonally
	if dir.length() > max_speed:
		velocity = dir.normalized() * max_speed
	else:
		velocity = dir
	velocity *= speed
	velocity = move_and_slide(velocity, Vector2.UP)
	update_hunger()


### SIGNALS/ACTIONS
signal winner
signal starved
signal at_end

func goal_entered():
	SoundEffects.play_sound("click")
	emit_signal("winner")
	Global.set_playing(false)
	play_animation("idle")

func set_starved():
	if not starved:
		Global.dprint((position - start_pos).length())
		starved = true
	emit_signal("starved")
	Global.dprint("starved")
	Global.level_score -= 25
	anim.play("die")

func eat(calories):
	Global.hunger = clamp(Global.hunger + calories, 0, Global.max_hunger)
	Global.dprint("Just ate " + str(calories) + " calories, hunger now at " + str(Global.hunger))
	starved = false
	start_pos = position
	Global.apples_left -= 1
	Global.level_score += 100
	
func update_hunger():
	Global.hunger -= (abs(velocity.length() / (max_speed * speed))) * 0.6
	if Global.hunger <= 0:
		set_starved()
		Global.hunger = 0

### LOOKS

func play_animation(animation):
	if anim.current_animation == animation:
		return
	else:
		anim.play(animation)

func set_look_angle():
	sprite.rotation = velocity.angle()
	if abs(sprite.rotation_degrees) > 90:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
