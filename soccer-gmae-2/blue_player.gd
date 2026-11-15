extends CharacterBody2D

var charged = false
var has_ball = false
var timer = 0
var aim = Vector2(-1, 0)

func _physics_process(delta): # physics
	var input_direction = Input.get_vector("p1_left", "p1_right", "p1_up", "p1_down")
	velocity = input_direction * 400
	move_and_slide()
	
	
	# setting var to nodes
	var ball = get_node("../Ball")  
	var red = get_node("../Red Player")

	timer -= delta # timer

	if position.distance_to(ball.position) < 70 and has_ball == false and timer <= 0:
		if ball.last_player == "blue":
			if ball.bounced == true:
				charged = true
		ball.last_player = "blue"
		ball.bounced = false
		has_ball = true
		red.has_ball = false
		red.timer = 1
		ball.held = true
		ball.get_node("CollisionShape2D").disabled = true

	if has_ball:
		ball.hold_pos = position + Vector2(0, 40)
	
	#fleche bouge
	if input_direction != Vector2.ZERO: # if not idle
		aim = input_direction
	$AimPivot.rotation = aim.angle()
	$AimPivot.visible = has_ball
	
	#shooter
	if has_ball and Input.is_action_pressed("p1_shoot"):
		has_ball = false
		timer = 0.3 #cooldown
		ball.bounced = false
		ball.held = false
		ball.get_node("CollisionShape2D").disabled = false
		ball.linear_velocity = aim.normalized() * 600
	
	get_node("../LeftBarrier/CollisionShape2D").disabled = charged # barrier opens if charged
	
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
