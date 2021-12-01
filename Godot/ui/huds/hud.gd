extends CanvasLayer

onready var top_hud = $TopHUD
onready var middle_hud = $MiddleHUD
onready var top_text = $TopHUD/VBoxContainer/Text/ReadyGo
onready var hunger_bar = $TopHUD/VBoxContainer/CenterContainer/HungerBar/ProgressBar
onready var middle_text = $MiddleHUD/CenterContainer/VBoxContainer/CenteredText
onready var anim = $AnimationPlayer
onready var apples_left_label = $TopHUD/VBoxContainer/CenterContainer/HungerBar/ApplesLeftLabel

func _ready() -> void:
	middle_hud.hide()
	top_hud.hide()
	
func toggle_top_hud(override: String = "") -> void:
	if override == "show":
		top_hud.show()
	if override == "hide":
		top_hud.hide()
	if top_hud.visible:
		top_hud.hide()
	else:
		top_hud.show()
	
func toggle_middle_hud(override: String = "") -> void:
	if override == "show":
		middle_hud.show()
	if override == "hide":
		middle_hud.hide()
	if top_hud.visible:
		middle_hud.hide()
	else:
		middle_hud.show()

func _physics_process(_delta):
	hunger_bar.value = (Global.hunger / Global.max_hunger) * 100
	apples_left_label.text = "Apples Left: " + str(Global.apples_left)
	
func set_top_text(text: String) -> void:
	top_text.text = text
	
func set_middle_text(text: String) -> void:
	middle_text.text = text
	
func fade_out_top_text() -> void:
	anim.play("fade_out_top_text")

func lose_game(reason: String = "You starved :(", _current_level: String = "") -> void:
	middle_text.text = reason
	top_hud.hide()
	middle_hud.show()
