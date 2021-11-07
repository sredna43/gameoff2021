extends Node2D

var draw_pos = null

func _draw():
	if !draw_pos: return
	draw_circle(draw_pos, 40, Color.white)

func _process(_delta):
	pass
	
func draw_at(pos):
	draw_pos = pos
	update()
