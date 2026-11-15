extends CharacterBody2D

var charged = false
func _physics_process(_delta):
	var input_direction = Input.get_vector("p1_left", "p1_right", "p1_up", "p1_down")
	velocity = input_direction * 400
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var thing = collision.get_collider()
		if thing is RigidBody2D:
			thing.apply_central_impulse(-collision.get_normal() * 20)
	
	if input_direction == Vector2.ZERO:
		if charged:
			$Sprite2D.frame = 1
		else:
			$Sprite2D.frame = 0
	else:
		if charged:
			$Sprite2D.frame = 3
		else:
			$Sprite2D.frame = 2
