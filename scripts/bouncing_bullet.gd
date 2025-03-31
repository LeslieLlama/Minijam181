extends bullet

var bounce_count = 0

func _process(delta: float) -> void:
	position += movementDirection

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.external_death()
		#queue_free()
	else:
		bounce_count += 1
		_bounce()
	
func _bounce():
	if bounce_count % 2 == 0: #bounce count is even
		movementDirection.y *= -1
	else: 
		movementDirection.x *= -1
	if bounce_count >= 8:
		queue_free()
		
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	pass
