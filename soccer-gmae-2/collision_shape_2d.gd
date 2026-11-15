extends CollisionShape2D


func _on_body_entered(body):
	if body.name == "Ball":
		body.hide()
		body.linear_velocity = Vector2(0, 0)

		await get_tree().create_timer(1).timeout

		body.position = Vector2(571, 325)
		get_node("../Blue Player").position = Vector2(877, 353)
		get_node("../Red Player").position = Vector2(292, 347)

		body.show()
