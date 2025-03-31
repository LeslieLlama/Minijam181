extends Area2D

var movementDirection : Vector2 = Vector2(-1,0)

func _process(delta: float) -> void:
	position += movementDirection

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.external_death()
		queue_free()
	else:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
