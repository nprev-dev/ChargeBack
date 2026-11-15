extends Area2D

func _on_body_entered(body):
	if body.name == "Ball":
		var label = get_node("../CanvasLayer/Label")

		body.hide()
		body.linear_velocity = Vector2(0, 0)
		label.show()

		await get_tree().create_timer(1).timeout
		label.hide()

		await get_tree().create_timer(0.3).timeout

		body.position = Vector2(571, 325)
		get_node("../Blue Player").position = Vector2(877, 353)
		get_node("../Red Player").position = Vector2(292, 347)
		
		get_node("../Blue Player").charged = false
		get_node("../Red Player").charged = false
		body.bounced = false
		
		body.show()
