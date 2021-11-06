extends Node2D

func _on_Goal_entered(body: Node2D):
	if body.has_method("goal_entered"):
		body.goal_entered()
