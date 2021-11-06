extends Node2D
class_name PlayerFSM

var states = {}
var active_state
var previous_state_tag = ""
var player

func init_states():
	for state in get_children():
		if state.tag:
			states[state.tag] = state
			
func init(_player):
	player = _player
	init_states()
	active_state = states.idle
	active_state.enter(player)
	
func run():
	var next_state_tag
	next_state_tag = active_state.run(player)
	if next_state_tag:
		change_state(next_state_tag)
		
func change_state(next_state_tag):
	var next_state = states.get(next_state_tag)
	if next_state:
		previous_state_tag = active_state.tag
		active_state.exit(player)
		active_state = next_state
		active_state.enter(player)
