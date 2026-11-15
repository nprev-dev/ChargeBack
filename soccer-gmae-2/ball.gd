extends RigidBody2D

var last_player = ""
var bounced = false
var held = false
var hold_pos = Vector2(0, 0)

func _integrate_forces(state):
	if held:
		state.transform.origin = hold_pos
		state.linear_velocity = Vector2(0, 0)

func _on_body_entered(body):
	if body.name == "Walls":
		bounced = true
