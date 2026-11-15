extends CharacterBody2D

var charged = false
var has_ball = false
var timer = 0
var aim = Vector2(1, 0)

func _physics_process(delta):
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * 400
	move_and_slide()

	var ball = get_node("../Ball")
	var blue = get_node("../Blue Player")

	timer -= delta

	if position.distance_to(ball.position) < 70 and has_ball == false and timer <= 0: 
		#si timer = 0, pas la balle et distance plus petit que 70 px
		if ball.last_player == "red":
			if ball.bounced == true:
				charged = true
		ball.last_player = "red"
		ball.bounced = false
		has_ball = true
		blue.has_ball = false
		blue.timer = 1 # puts red in steal timer
		ball.held = true
		ball.get_node("CollisionShape2D").disabled = true # disable ball physics when player steals it

	if has_ball:
		ball.hold_pos = position + Vector2(0, 40)
	if input_direction != Vector2.ZERO:
		aim = input_direction
	$AimPivot.rotation = aim.angle()
	$AimPivot.visible = has_ball
	
	if has_ball and Input.is_action_pressed("p2_shoot"):
		has_ball = false
		timer = 0.3 #cooldown
		ball.bounced = false
		ball.held = false
		ball.get_node("CollisionShape2D").disabled = false
		ball.linear_velocity = aim.normalized() * 600

	get_node("../RightBarrier/CollisionShape2D").disabled = charged # barrier opens if charged

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
