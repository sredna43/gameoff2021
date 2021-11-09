extends CanvasLayer

onready var hunger_bar = $TopHUD/VBoxContainer/HungerBar/ProgressBar

func start_level():
	$AnimationPlayer.play("start")

func _physics_process(delta):
	hunger_bar.value = (Global.hunger / Global.max_hunger) * 100
