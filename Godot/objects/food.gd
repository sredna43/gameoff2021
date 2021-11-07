extends Node2D

export var calories = 200
onready var anim: AnimationPlayer = $AnimationPlayer

func _on_Food_entered(body: Node2D):
	if body.has_method("eat"):
		body.eat(calories)
		anim.play("eaten")
